function y = funcion(x,z)
y = zeros(4,1);         
y(1) = 2*x*z(1)*z(4);
y(2) = 10*x*z(4)*z(1)^5;
y(3) = 2*x*z(4);
y(4) = -2*x*(z(3)-1);