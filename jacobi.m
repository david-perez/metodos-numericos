function [u, reason] = jacobi(A, b, it, p)
    n = size(A, 1);
    if size(A, 2) ~= n
        disp('La matriz A no es cuadrada.')
        return;
    end
    if length(b) ~= n
        disp('El vector b no tiene el mismo número de filas que la matriz A.')
        return;
    end
    
    reason = 0;
    bn = norm(b);
    r = zeros(n, 1);
    d = zeros(n, 1);
    u = zeros(n, 1);
    for k = 1:it
        r = b' - A * u;
        if norm(r) < p * bn
            reason = 1;
            break;
        end
        d = r ./ diag(A);
        u = u + d;
    end
end