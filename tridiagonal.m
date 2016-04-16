function x = tridiagonal(A, d)
    n = size(A, 1);
    if size(A, 2) ~= n
        disp('La matriz A no es cuadrada.')
        return;
    end
    if n ~= length(d)
        disp('El vector d no tiene el mismo número de filas que la matriz A.')
        return;
    end
    
    % Preallocate, just in case.
    m = zeros(n, 1);
    g = zeros(n, 1);
    m(1) = A(1,1);
    if m(1) == 0
        disp('La matriz A no tiene todos sus menores principales distintos de cero.')
        return;
    end
    g(1) = d(1) / m(1);
    
    for k = 2:n
        m(k) = A(k,k) - A(k-1,k) / m(k-1) * A(k,k-1);
        if m(k) == 0
            disp('La matriz A no tiene todos sus menores principales distintos de cero.')
            return;
        end
        g(k) = (d(k) - g(k-1) * A(k,k-1)) / m(k);
    end
    
    x(n) = g(n);
    for k = n-1:-1:1
        x(k) = g(k) - A(k,k+1) / m(k) * x(k+1);
    end
end