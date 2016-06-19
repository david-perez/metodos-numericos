function lagrange_newton_loader
    disp('Vamos a plottear una función en un intervalo [a, b], junto con su polinomio de interpolación.');
    astr = input('Valor de a: ');
    bstr = input('Valor de b: ');
    eval('a = astr;');
    eval('b = bstr;');
    x = linspace(a, b);

    fstr = input('Introduce una función en la variable x tal y como te la devolvería MATLAB tras pasarla por vectorize():', 's');
    y = eval(fstr);
    eval(['f = @(x) ', fstr]);

    n = input('Introduce el número de puntos (que estarán equiespaciados en [a, b]) para el cálculo del polinomio de interpolación: ');
    h = (b - a) / n;
    n = n + 1; % Para que pinte b.

    p = a;
    T = zeros(n, 2);
    for i = 1:n
        T(i, 1) = p;
        T(i, 2) = f(p);
        p = p + h;
    end    

    hold on
    [pol, Pi, T] = lagrange_newton(T);
    plot(x, y);
    hold off

    while (true) % MATLAB no tiene do-whiles.
        b = input('¿Deseas añadir otro punto de interpolación (1/0)?:');
        if (b == 1)
            x = input('Coordenada x del punto:');
        
            hold on
            [pol, Pi, T] = addPoint(x, f(x), pol, Pi, T);
            hold off
        else
            break;
        end
    end
end

function [pol, Pi, T] = addPoint(x, y, pol, Pi, T)
    n = size(T, 1);
    T = [T; [x, y]];
    
    for i = n:-1:1
        T(i,2) = (T(i,2) - T(i+1,2))/(T(i,1) - T(n+1,1));
    end
    
    pol = [0, pol] + Pi * T(1,2);
    Pi = [Pi, 0] - [0, Pi .* T(n+1,1)];
    
    r = linspace(min(T(:,1)), max(T(:,1)), 100);
    plot(r, polyval(pol, r));
end