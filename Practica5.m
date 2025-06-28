clear all;      % Clear everything

% Input data will come through a routine
[a,b,eta,h,N,f,fsol,norma] = datosRKI();

% Open a file to store the output. If we want to print to screen,
% fichero = 1 means print to screen
fichero = fopen('salida_datosRKI.txt','w');

% Call the implicit Runge Kutta numerical method
%A = [1/4 0; 1/2 1/4];
%vc = [1/4 3/4];
%vb = [1/2 1/2];

A = [1/4 1/4-sqrt(3)/6; 1/4+sqrt(3)/6 1/4];
vc = [1/2-sqrt(3)/6 1/2+sqrt(3)/6];
vb = [1/2 1/2];

[x,y,error,sol] = RungeKuttaImplicito(a, h, N, eta, f, norma, A, vb, vc, fsol);
%[x,y,error,sol] = RungeKuttaDIRK(a, h, N, eta, f, norma, A, vb, vc, fsol);

% To do the DIRK and implicit for Legendre

% DID YOU ADD THE SOLUTION??

% Output data
disp(x);
disp(y);
disp(error);
disp(sol);

% IF YOU WANT TO PLOT THE SOLUTION, ADD IT AT THE END, OTHERWISE DON'T ADD ANYTHING
% WE PASS SOL, NOT FSOL
dibuja_graficas(x,y,sol);
escribir_resultados(fichero,x,y, abs(y-sol));      % IF WE WANT TO INCLUDE THE ERROR IT WILL BE abs(y-sol)!!!!!!

% TO CALCULATE THE NORM OF Y OR Y' AT A SPECIFIC POINT: E.G. 2.4
p = 1+(2.4-a)/h;
X = sprintf('%d  %e  %e',p-1,abs(y(p,1)-sol(p,1)),abs(y(p,2)-sol(p,2)));
disp(X);

disp(norm(y(:,1)-sol(:,1),inf)); % Maximum of one component (in this case the first) evaluated at all points

%disp(norm((y-sol),inf));
% Close the file
fclose(fichero);

% The error vector at each index i gives the norm of the vector formed by the different
% dimensions of (y_i - sol_i), that is, it gives the norm of the solution minus
% the approximate solution at a point. If the solution is scalar, it will be the
% value of the subtraction, and if the solution is vectorial it will be the norm of that
% vector
