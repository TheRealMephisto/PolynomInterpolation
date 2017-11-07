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
function [a, b, c, d] = hermiteSplineDegree3(x, f, df)
% x ist ein Vektor und beinhaltet n+1 Stützstellen.
% f sind die zugehörigen n+1 Funktionswerte.
% df sind die zugehörigen n+1 Werte der Ableitungen.
% a, b, c, d beinhalten die Koeffizienten für n Splines dritter Ordnung.
% Never forget, that GNU Octave starts indexing with "1"!
%
%	Get the dimension, check that n >= 2 and that x, f and df are of the same length
	n = (length(x)-1);
	if ( n < 2)
		printf("x, f and df need at least two components!");
		return;
	endif
	if ( n != (length(f)-1) || n != (length(f)-1) )
		printf("x, f, and df are not vectors of the same length!");
		return;
	endif
%	Calculate the distance vector h, it contains n elements
	h = ones(n, 1);
	for i = 1:n
		h(i) = x(i+1) - x(i);
	endfor
%	Calculate the lambdas
	lambdas = calcLambdas(n, h);
%	Calculate the mus
	mus = calcMus(n, h);
%	Calculate the deltas
	deltas = calcDeltas(n, h, f, df);
%	Set the values of the a's
	a = f(1:n)';
%	Calculate the c's
	c = calcC(n, lambdas, mus, deltas);
%	Calculate the b's
	b = calcB(n, h, c, f);
%	Calculate the d's
	d = calcD(n, h, c);
%	Cut off the last c
	c = c(1:n);
%	% Print the calculated numbers
	printInfo(x, f, df, n, h, lambdas, mus, deltas, a, b, c, d);
endfunction

function retLambdas = calcLambdas(n, h)
	retLambdas = ones(n, 1);
	for i = 2:n
		retLambdas(i) = h(i) / (h(i) + h(i-1));
	endfor
endfunction

function retMus = calcMus(n, h)
	retMus = nan((n+1), 1);
	for i = 2:n
		retMus(i) = h(i-1)/(h(i)+h(i-1));
	endfor
	retMus(n+1) = 1;
endfunction

function retDeltas = calcDeltas(n, h, f, df)
	retDeltas = ones((n+1), 1);
	retDeltas(1) = (6/h(1))*(((f(2)-f(1))/h(1))-df(1));
	for i = 2:n
		retDeltas(i) = (6/(h(i)+h(i-1)))*(((f(i+1)-f(i))/h(i))-((f(i)-f(i-1))/h(i-1)));
	endfor
	retDeltas(n+1) = (6/h(n))*(df(n+1)-((f(n+1)-f(n))/h(n)));
endfunction

function retC = calcC(n, lambdas, mus, deltas)
	retC = nan((n+1), 1);
	A = zeros(n+1);
	A(1, 1) = 2;
	A(1, 2) = lambdas(1);
	counter = 1;
	for i = 2:n
		A(i, counter) = mus(i);
		A(i, (counter+1)) = 2;
		A(i, (counter+2)) = lambdas(i);
		counter++;
	endfor
	A((n+1), n) = mus((n+1));
	A((n+1), (n+1)) = 2;
	retC = A \ deltas;
  A % print A
endfunction

function retB = calcB(n, h, c, f)
	retB = nan(n, 1);
	for i = 1:n
		retB(i) = ((f(i+1)-f(i))/h(i)) - ((h(i)/6)*(c(i+1)+2*c(i)));
	endfor
endfunction

function retD = calcD(n, h, c)
	retD = nan(n, 1);
	for i = 1:n
		retD(i) = ((c(i+1)-c(i))/h(i));
	endfor
endfunction

function printInfo(x, f, df, n, h, lambdas, mus, deltas, a, b, c, d)
	infoOutput = "x_i: ";
	for i = 1:(n+1)
		infoOutput = [infoOutput, sprintf(" %d; ", x(i))];
	endfor
	infoOutput = [infoOutput, "\nf_i: "];
	for i = 1:(n+1)
		infoOutput = [infoOutput, sprintf(" %d; ", f(i))];
	endfor
	infoOutput = [infoOutput, "\ndf_i: "];
	for i = 1:(n+1)
		infoOutput = [infoOutput, sprintf(" %d; ", df(i))];
	endfor
	infoOutput = [infoOutput, "\nh_i: "];
	for i = 1:n
		infoOutput = [infoOutput, sprintf(" %d; ", h(i))];
	endfor
	infoOutput = [infoOutput, "\nlambda_i: "];
	for i = 1:n
		infoOutput = [infoOutput, sprintf(" %d; ", lambdas(i))];
	endfor
	infoOutput = [infoOutput, "\nmu_i: "];
	for i = 1:(n+1)
		infoOutput = [infoOutput, sprintf(" %d; ", mus(i))];
	endfor
	infoOutput = [infoOutput, "\ndelta_i: "];
	for i = 1:(n+1)
		infoOutput = [infoOutput, sprintf(" %d; ", deltas(i))];
	endfor
	infoOutput = [infoOutput, "\na_i: "];
	for i = 1:n
		infoOutput = [infoOutput, sprintf(" %d; ", a(i))];
	endfor
	infoOutput = [infoOutput, "\nb_i: "];
	for i = 1:n
		infoOutput = [infoOutput, sprintf(" %d; ", b(i))];
	endfor
	infoOutput = [infoOutput, "\nc_i: "];
	for i = 1:n
		infoOutput = [infoOutput, sprintf(" %d; ", c(i))];
	endfor
	infoOutput = [infoOutput, "\nd_i: "];
	for i = 1:n
		infoOutput = [infoOutput, sprintf(" %d; ", d(i))];
	endfor
	infoOutput = [infoOutput, "\n"];
	printf(infoOutput);
endfunction
