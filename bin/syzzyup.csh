
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


# FIXME: figure this out automatically
#setenv syz_version 0.1.1
setenv syz_version devel

if ( -e /sw/syzix/noarch/syz/$syz_version/bin/syzlib.csh && { source /sw/syzix/noarch/syz/$syz_version/bin/syzlib.csh } ) then
	#echo "got it first up"
	:
else if ( -e /sw/syzix/hostdep/noarch/syz/$syz_version/bin/syzlib.csh && { source /sw/syzix/hostdep/noarch/syz/$syz_version/bin/syzlib.csh } ) then
	#echo "got it second up"
	:
else
	echo "syzzyup.csh: Error: cannot source syzlib" > /dev/stderr
	exit 1    # Causes noise in the outer shell, oh well - it's possibly by design.
endif


# Q: Who feels like porting the rest of this to the inferior shell...?
# A: Not me.

echo "FIXME: syzzyup.csh not fully implemented"


