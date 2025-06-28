function escribe_paso(fid,k,x,y,err)
%
% Function escribe_paso(fid, k, x, y, err)
%
% Function that prints the evolution of the independent variable, 
% the dependent variables, and the (optional) error 
% at the discretization nodes for the initial value problem:
%   | y'(x) = f(x, y(x))
%   | y(x = x0) = y_0
%
% Input:
% fid: file identifier. Use 1 for screen output.
%   k: integer indicating the current step.
%   x: independent variable in the ODE.
%   y: vector containing the dependent variables.
% err: vector containing the error between the exact and approximate 
%      solutions.
%
% Output:
%   This routine prints to the screen or to a file the step number, 
%   the independent variable, the dependent variables, and, 
%   if desired, the error. Different formats are used depending 
%   on the length of y.
%

n = length(y);

fprintf(fid,'| %5i   | %10.3e | %10.3e |',k,x,y(1));
if(n == 2)
    fprintf(fid,' %10.3e |',y(2));
end
if(nargin==5)
  fprintf(fid,' %10.3e |',err(1));
    if(n == 2)
        fprintf(fid,' %10.3e |',err(2));
    end  
end

if(n>2)
    for i=2:n;
        fprintf(fid,'\n');
        fprintf(fid,'|         |            ');
        fprintf(fid,'| %10.3e |',y(i)); 
        if(nargin==5)
            fprintf(fid,' %10.3e |',err(i));
        end
    end
end
    
fprintf(fid,'\n');
fprintf(fid,'-------------------------------------');
if(n == 2 )
    fprintf(fid,'-------------');
end
if(nargin==5)
    fprintf(fid,'-------------');
    if(n == 2 )
        fprintf(fid,'-------------');
    end
end
fprintf(fid,'\n');

return 