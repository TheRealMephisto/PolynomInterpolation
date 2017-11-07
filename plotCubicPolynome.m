%
% Copyright (C) {2017}  {Maximilian Rettinger <max@wechsel-wissen.de>}
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%
function plotCubicPolynome(I, a, b, c, d)
% This function will plot the polynomial given by p(x) = a + b*x + c*x^2 + d*x^3
% I is a vector with three components describing the interval, such that I(1) is the left boundary,
% I(3) is the right boundary and I(2) is the size of the steps - the higher that number, the better the resolution.
% a, b, c, d are scalars
%
%	Check for correct input
	if (length(I) != 3)
		printf("I must be a vector of length 3! \n I = [ left boundary, step size, right boundary ]");
	endif
	if (length(a) != 1 || length(b) != 1 || length(c) != 1 || length(d) != 1)
		printf("a, b, c and d must be scalars! \n The describe p(x) = a + b*x + c*x^2 + d*x^3");
	endif
%	Set the Interval on which the polynomial will be plotted
	x = I(1):I(2):I(3);
%	Plot the polynomial
	plot(x, a + b*x + c*x.^2 + d*x.^3);
%	Label the plot
	xlabel("x");
	ylabel(sprintf("%d + %d*x + %d*x^2 + %d*x^3", a, b, c, d));
	title("Beautiful plot of my cubic polynomial");
endfunction
