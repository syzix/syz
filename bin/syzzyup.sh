
# Copyright (C) 2012 Kevin Pulo.
#
# This file is part of syz.
# 
# syz is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# syz is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with syz.  If not, see <http://www.gnu.org/licenses/>.


# this is suitable for bash4+ only...

# plus make this safe to rerun at any time - reruns *must* *do* *NOTHING*
# then /shbang can run this, just in case (maybe)

#echo $BASH_SOURCE
#. syzlib

# FIXME: figure this out automatically
#syz_version=0.1.1
syz_version=devel

{ [ -e /sw/syzix/noarch/syz/$syz_version/bin/syzlib ] && . /sw/syzix/noarch/syz/$syz_version/bin/syzlib ; } || { [ -e /sw/syzix/hostdep/noarch/syz/$syz_version/bin/syzlib ] && . /sw/syzix/hostdep/noarch/syz/$syz_version/bin/syzlib ; } || { echo "syzzyup: Error: cannot source syzlib" 1>&2 ; exit 1; }




resolve_necessary program modulecmd modules || return 1
resolve_necessary program syzcmd syz || return 1
resolve_necessary program shwrapnel shwrapnel || return 1
resolve_necessary program tclsh tcl || return 1

resolve_necessary tcl_package modext modext || return 1

if envvar_unset LOADEDMODULES; then
	LOADEDMODULES=""
	export LOADEDMODULES
fi


if envvar_unset MODULEPATH; then
	MODULEPATH=""
	export MODULEPATH
fi

for repo in "${syzix_repos[@]}"; do
	for arch in "${syzix_archs[@]}"; do
		i="$repo/$arch"
		if [ -d "$i" -a -r "$i" -a -x "$i" ]; then
			append-path MODULEPATH "$i/.sf"
		fi
	done
done

syz() { eval `syzcmd bash "$@" ; echo local rc=$?`; return $rc; }
export -f syz

if envvar_set USE_TRADITIONAL_MODULE_COMMAND; then
	module() { syz "$@"; }
	export -f module
fi

# FIXME: once syzzyup is called by the syz syzfile (using legacy-script) (to
# handle using "syz swap" to change syz versions), then this must only be done
# when syzzyup is NOT being called in this case.
#syz ensure syz/$syz_version
syz load syz/$syz_version

