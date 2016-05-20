function [u_k1, reason] = relajacion(A, b, it, p, w)
    n = size(A, 1);
    if size(A, 2) ~= n
        disp('La matriz A no es cuadrada.')
        return;
    end
    if length(b) ~= n
        disp('El vector b no tiene el mismo número de filas que la matriz A.')
        return;
    end
    
    bn = norm(b);
    r = zeros(n, 1);
    d = zeros(n, 1);
    u_k = zeros(n, 1);
    u_k1 = zeros(n, 1);
    for k = 1:it
        for i = 1:n
            r(i) = b(i) - A(i, 1:i-1) * u_k1(1:i-1) - A(i, i:n) * u_k(i:n);
            d(i) = w * r(i) / A(i, i);
            u_k1(i) = u_k(i) + d(i);
        end
        u_k = u_k1;
        if norm(r) < p * bn
            reason = 1;
            break;
        end
    end
end