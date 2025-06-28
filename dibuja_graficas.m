function dibuja_graficas(x,y,fsol)
    
    M = length(y(1,:));
    if (nargin == 3)
        for k = 1:M                     %plot yn and its solution
                figure(k);                  % Create a new window to show all plots after execution, not just the last one

                plot(x,y(:,k),'r.',x,fsol(:,k),'b-');        %red the aproximation and blue the solution
        end
    else
        for k = 1:M                     %Plot yn and its solution
                figure(k);                  
                plot(x,y(:,k),'r.');        
        end
    
    
end