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
function plotCubicSpline(Z, a, b, c, d)
% This function will plot the polynomial given by p_i(x) = a(i) + b(i)*x + c(i)*x^2 + d(i)*x^3
% Z is a matrix containing vectors I, each with three components describing the interval, such that I(1) is the left boundary,
% I(3) is the right boundary and I(2) is the size of the steps - the higher that number, the better the resolution.
% a, b, c, d are vectors.
%
%	Set the Intervals on which the spline will be plotted
	n = size(Z)(1);
%	Plot the polynomial
	hold on;
	for i = 1:n
		xi = Z(i, 1);
		x = xi:Z(i, 2):Z(i, 3);
		plot(x, a(i) + b(i)*(x-xi) + (c(i)/2)*(x-xi).^2 + (d(i)/6)*(x-xi).^3);
	endfor
%	Label the plot
	xlabel("x");
	ylabel("Spline Interpolation");
	title("Beautiful plot of my spline interpolation");
	hold off;
endfunction
