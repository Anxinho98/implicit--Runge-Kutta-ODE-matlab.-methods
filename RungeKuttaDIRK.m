function [r,s,t,u] = RungeKuttaDIRK(a, h, N, eta, f, norma, A, vb, vc, fsol)  % IF WE DON'T HAVE THE SOLUTION, WE PASS NULL

    % VARIABLE DECLARATION
    M = length(eta);                  % Dimension of the solution
    p = norma;                       % Type of norm
    L = length(vb);

    % INITIALIZATION OF VARIABLES

    x = zeros(N+1, 1);               % Vector of algorithm steps
    y = zeros(N+1, M);               % Matrix where each column (M columns, one per component of y_i) contains values at the N+1 points.
    k = zeros(L, M);                 % The Ks with dimensions L x M
    A_diag_nula = A - diag(diag(A));% Matrix equal to A but with zeros on the diagonal
    % Initial Conditions

    x(1) = a;                       % a belongs to R
    y(1,:) = eta;                   % eta belongs to R^n
    opciones = optimset('Display','off','TolFun',1.e-8,'TolX',1.e-8);
    flag = 0;                       % Flag: 0 = NO SOLUTION   1 = SOLUTION PROVIDED

    % In case the solution is different from NULL:

    if (nargin == 10)
        sol = zeros(N+1, M);        % Matrix where each column (M components) contains the exact solution evaluated at N+1 points
        error = zeros(N+1, 1);      % Vector with the infinity norms of the difference between y_n and sol_n
        sol(1,:) = eta;             % Equals eta
        error(1) = norm(y(1,:) - sol(1,:), p);   % Write error(1) outside loop (should be zero)
        flag = 1;
    end   

    % Code

    if(flag == 1)        % IF THERE IS A SOLUTION:
        z0 = transpose(f(x(1), y(1,:)));        % OPTION 1
        for i = 1:N               % Build the full vector function (all its dimensions) at each point
            x(i+1) = x(i) + h;                        % Create next point

            for j = 1:L
                fk = @(z) z - transpose(f(x(i) + vc(j)*h, y(i,:) + h*A(j,j)*z + h*A_diag_nula(j,:)*k));
                k(j,:) = fsolve(fk, z0, opciones);    
                z0 = k(j,:);
            end
            y(i+1,:) = y(i,:) + h * (vb*k);          % Compute y_i+1 with all its components directly
            sol(i+1,:) = transpose(fsol(x(i+1)));    % Assign exact solution at point i+1 in all M components
            error(i+1) = norm(y(i+1,:) - sol(i+1,:), p);   % Calculate p-norm of error between y_i+1 and sol_i+1

        end

        r = x;          % Outputs
        s = y;
        t = error;
        u = sol;

    else  % IF THERE IS NO SOLUTION
        z0 = transpose(f(x(1), y(1,:))); 
        for i = 1:N               % Build the full vector function (all dimensions) at each point
            x(i+1) = x(i) + h;                        % Create next point
            for j = 1:L
                fk = @(z) z - transpose(f(x(i) + vc(j)*h, y(i,:) + h*A(j,j)*z + h*A_diag_nula(j,:)*k));
                k(j,:) = fsolve(fk, z0, opciones);   
                z0 = k(j,:);
            end

            y(i+1,:) = y(i,:) + h * (vb*k);          % Compute y_i+1 with all components directly    

        end

        r = x;      % Outputs
        s = y;
        t = 'No solution was provided, so no error calculation';
        u = 'No solution was provided';
    end
end

