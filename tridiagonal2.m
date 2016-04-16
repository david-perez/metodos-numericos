function x = tridiagonal2(a, b, c, d)
    n = length(b);
    if n ~= length(b) || n-1 ~= length(c) || n-1 ~= length(a) || n ~= length(d)
        disp('Los vectores a, b y c deben formar una matriz tridiagonal.')
        return;
    end
    if n ~= length(d)
        disp('El vector d no tiene el mismo número de filas que la matriz tridiagonal.');
        return;
    end
    
    % Preallocate, just in case.
    m = zeros(n, 1);
    g = zeros(n, 1);
    m(1) = b(1);
    if m(1) == 0
        disp('La matriz A no tiene todos sus menores principales distintos de cero.')
        return;
    end
    g(1) = d(1) / m(1);
    
    for k = 2:n
        m(k) = b(k) - c(k-1) / m(k-1) * a(k-1);
        if m(k) == 0
            disp('La matriz A no tiene todos sus menores principales distintos de cero.')
            return;
        end
        g(k) = (d(k) - g(k-1) * a(k-1)) / m(k);
    end
    
    x(n) = g(n);
    for k = n-1:-1:1
        x(k) = g(k) - c(k) / m(k) * x(k+1);
    end
end