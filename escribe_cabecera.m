 function escribe_cabecera(fid,x,y,err)
%
% Function escribe_cabecera(fid, x, y, err)
%
% Function that prints a header for displaying the evolution of the 
% independent variable, the dependent variables, and the (optional) 
% error at the discretization nodes for the initial value problem:
%   | y'(x) = f(x, y(x))
%   | y(x = x0) = y_0
%
% This routine should be called before escribe_paso.m
%
% Input:
% fid: file identifier. Use 1 for screen output.
%   x: independent variable in the ODE (not used in this function).
%   y: vector containing the dependent variables (only used to 
%      determine the number of components).
% err: vector containing the error between the exact and approximate 
%      solutions (not used in this function).
%
% Output:
%   This routine only produces a header, whose format depends on the 
%   number of components in y. The output is either to a file or to the 
%   screen.
%
   

n = length(y);

fprintf(fid,'-------------------------------------');
if(n == 2 )
    fprintf(fid,'-------------');
end
if(nargin==4)
    fprintf(fid,'-------------');
    if(n == 2 )
        fprintf(fid,'-------------');
    end
end
fprintf(fid,'\n');
fprintf(fid,'|  Nodo   |     x      |');
if(n > 2 || n == 1)
    fprintf(fid,       '      y     |');
elseif (n == 2)
    fprintf(fid,       '     y_1    |     y_2    |');
end
if(nargin==4)
    if(n > 2 || n == 1)
        fprintf(fid,   '    err     |');
    elseif (n == 2)
        fprintf(fid,   '    err_1   |    err_2   |');
    end
end
fprintf(fid,'\n');
fprintf(fid,'-------------------------------------');
if(n == 2 )
    fprintf(fid,'-------------');
end
if(nargin==4)
    fprintf(fid,'-------------');
    if(n == 2 )
        fprintf(fid,'-------------');
    end
end

fprintf(fid,'\n');

return 