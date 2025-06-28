function [a,b,eta,h,N,f,fsol,norma]=datosRKI()


f =@funcion;              %ODE´s function 
fsol=@solucion;           %ODE´s solution


a = 0;                      %X0
b = 3;                      %b
h = 0.005;                   %step
N = floor((b-a)/h);         %Number of steps
eta = [1 1 1 1];                % y(x0)

norma = inf;                %Type of norm
