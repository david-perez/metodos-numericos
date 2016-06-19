function spline(T, type, r, yp0, ypn)
    % T es un vector (n+1)*2.
    % En la primera columna están x0, x1, ..., xn
    % En la segunda columna están y0, y1, ..., yn
    % type es el tipo de función spline interpoladora, I o II.
    % Si type es 2, yp0 es y'0, ypn es y'n.
    % r es igual a 0 si esta función ha sido llamada desde spline_loader, 1 en otro caso.
    
    n = size(T, 1) - 1; % número puntos menos 1.
    
    % Pre-allocate.
    h = zeros(n, 1);
    lam = zeros(n, 1);
    mu = zeros(n, 1);
    d = zeros(n+1, 1);
    
    h(1) = T(2, 1) - T(1, 1);
    for j = 1:n-1
        h(j+1) = T(j+2, 1) - T(j+1, 1);
        lam(j+1) = h(j+1)/(h(j) + h(j+1));
        mu(j) = 1 - lam(j+1);
        d(j+1) = 6/(h(j) + h(j+1)) * ((T(j+2,2) - T(j+1,2))/h(j+1) - (T(j+1,2) - T(j,2))/h(j));
    end
    
    if type == 1
        lam(1) = 0;
        d(1) = 0;
        mu(n) = 0;
        d(n+1) = 0;
    elseif type == 2
        lam(1) = 1;
        d(1) = 6/h(1) * ((T(2, 2) - T(1, 2))/h(1) - yp0);
        mu(n) = 1;
        d(n+1) = 6/h(n) * (ypn - (T(n+1, 2) - T(n, 2))/h(n));
    end
    
    M = tridiagonal2(mu, ones(n+1, 1) * 2, lam, d);
    
    m = zeros(n, 4);
    for j = 1:n
        a = (T(j+1, 2) - T(j, 2))/h(j) - (2*M(j) + M(j+1))/6 * h(j);
        b = M(j)/2;
        c = (M(j+1)-M(j))/(6*h(j));
        
        m(j, 1) = c;
        m(j, 2) = -3*c * T(j, 1) + b;
        m(j, 3) = 3*c * T(j, 1)^2 - 2*b * T(j, 1) + a;
        m(j, 4) = -c * T(j, 1)^3 + b * T(j, 1)^2 - a * T(j, 1) + T(j, 2);
    end
    
    if r == 1
        hold on
    end
    for j = 1:n
        r = linspace(T(j, 1), T(j+1, 1), 100);
        plot(r, polyval(m(j, :), r));
    end
    if r == 1
        hold off
    end
end