function [r,s,t,u] = RungeKuttaImplicito(a, h, N, eta, f, norma, A, vb, vc, fsol)  % IF WE DON'T HAVE THE SOLUTION, PASS NULL

    % VARIABLE DECLARATION
    M = length(eta);                  % Dimension of the solution
    p = norma;                       % Type of norm
    
    % VARIABLE INITIALIZATION

    x = zeros(N+1, 1);      % Vector of the algorithm steps
    y = zeros(N+1, M);      % Matrix where each column (M columns, as many as dimensions of y_i) is one component of y_i(), evaluated at the N+1 points
    k1 = zeros(1,M);
    k2 = zeros(1,M);
    % Initial conditions

    x(1) = a;               % a belongs to R
    y(1,:) = eta;           % eta belongs to R^n
    opciones = optimset('Display','off','TolFun',1.e-8,'TolX',1.e-8);
    flag = 0;               % Has two values: 0 = NO SOLUTION   1 = WITH SOLUTION
    
    % In case the solution is different from NULL:

     if (nargin == 10)
        sol = zeros(N+1, M);    % Matrix where each column (M columns, as many as dimensions of the solution) is one component of the solution, evaluated at the N+1 points
        error = zeros(N+1,1);   % Vector with infinity norms of each y_n minus sol_n
        sol(1,:) = eta;         % Will be equal to eta
        error(1) = norm(y(1,:) - sol(1,:),p);     % Write error(1) because it can't be done inside the loop (also should be 0)
        flag = 1;
     end   
     
    % Code
    
    if(flag == 1)        % In case THERE IS A SOLUTION:

        z0 = [f(x(1),y(1,:)),f(x(1),y(1,:))];            % Initial condition for the first iterate
        
        for i = 1:N               % We create the full vector function (with all its dimensions) for each point
            x(i+1) = x(i) + h;                                          % Create the next point
            FGL2 = @(z)[z(1:M) - transpose(f(x(i) + vc(1)*h, y(i,:) + h*(A(1,1)*z(1:M) + A(1,2)*z(M+1:2*M)))), ...
                        z(M+1:2*M) - transpose(f(x(i) + vc(2)*h, y(i,:) + h*(A(2,1)*z(1:M) + A(2,2)*z(M+1:2*M))))];
            z0 = fsolve(FGL2, z0, opciones);
            k1 = z0(1:M);
            k2 = z0(M+1:2*M);
            
            y(i+1,:) = y(i,:) + h*(vb(1)*k1 + vb(2)*k2);
            sol(i+1,:) = transpose(fsol(x(i+1)));                       % Assign its value to the solution at point i+1 in M dimensions or components
            error(i+1) = norm( y(i+1,:) - sol(i+1,:), p);               % Calculate the p-norm of the error between y_i+1 and sol_i+1
            
        end
        
        r = x;          % Output data
        s = y;
        t = error;
        u = sol;
     
     else  % In case THERE IS NO SOLUTION
        
        z0 = [f(x(1),y(1,:)),f(x(1),y(1,:))];            % Initial condition for the first iterate
        
        for i = 1:N               % We create the full vector function (with all its dimensions) for each point
            x(i+1) = x(i) + h;                                          % Create the next point
            FGL2 = @(z)[z(1:M) - transpose(f(x(i) + vc(1)*h, y(i,:) + h*(A(1,1)*z(1:M) + A(1,2)*z(M+1:2*M)))), ...
                        z(M+1:2*M) - transpose(f(x(i) + vc(2)*h, y(i,:) + h*(A(2,1)*z(1:M) + A(2,2)*z(M+1:2*M))))];
            z0 = fsolve(FGL2, z0, opciones);
            k1 = z0(1:M);
            k2 = z0(M+1:2*M);
            
            y(i+1,:) = y(i,:) + h*(vb(1)*k1 + vb(2)*k2);
        end
    
        
        r = x;      % Output data
        s = y;
        t = 'No solution was introduced, so there is no error';
        u = 'No solution was introduced';
     end
end
