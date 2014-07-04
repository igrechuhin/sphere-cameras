## Copyright (C) 2014 Илья Гречухин
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} rad2deg (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Илья Гречухин <Ilya@mac-mini-ila>
## Created: 2014-07-04

function [deg] = rad2deg (rad)

deg = rad * 180.0 / pi;

endfunction
