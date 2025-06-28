function y = solucion(x)
y = zeros(4,1);             
y(1) = exp(sin(x^2));
y(2) = exp(5*sin(x^2));
y(3) = sin(x^2)+1;
y(4) = cos(x^2);