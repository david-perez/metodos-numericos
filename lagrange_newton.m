function [pol, Pi, T] = lagrange_newtonI(T)
    % tabla es un vector (n+1)*2.
    % En la primera columna están x0, x1, ..., xn
    % En la segunda columna están f(x0), f(x1), ..., f(xn)
    
    n = size(T, 1) - 1; % número puntos menos 1.
    
    Pi = [1];
    pol = [];
    for k = 0:n-1      
        pol = [0 pol] + Pi * T(1, 2);
        Pi = [Pi 0] - [0, Pi .* T(k+1, 1)];
        
        for i = 1:n-k
            T(i, 2) = (T(i, 2) - T(i+1, 2)) / (T(i, 1) - T(i+k+1, 1));
        end
    end
    
    pol = [0 pol] + Pi * T(1, 2);
    Pi = [Pi 0] - [0, Pi .* T(n+1, 1)]; % Esto solamente es necesario si vas a añadir más puntos usando Pi.
    
    r = linspace(min(T(:,1)), max(T(:,1)), 100);
    plot(r, polyval(pol, r));
end