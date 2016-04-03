function [u, A] = cholesky(A, b)
    n = size(A, 1);
    if size(A, 2) ~= n
        disp('La matriz A no es cuadrada.')
        return;
    end
    if length(b) ~= n
        disp('El vector b no tiene el mismo número de filas que la matriz A.')
        return;
    end
    
    if nargout == 2 % calcular B primero
        for i = 1:n % calcular la columna i
            s = sum(A(i,1:i-1) .* A(i,1:i-1));
        
            if A(i, i) <= s
                disp('La matriz A no admite factorización de Cholesky.')
            end
            A(i, i) = sqrt(A(i, i) - s);
        
            for j = i+1:n
                A(j, i) = 1 / A(i,i) * (A(i, j) - sum(A(i,1:i-1) .* A(j,1:i-1)));
            end
        end
    end
    
    % La parte triangular inferior de A contiene B
    w = solve_for_w(A, b);
    u = solve_for_u(A', w);
end

% Resuelve el sistema triangular inferior Bw = b.
% Precondición: length(b) = size(B, 1).
function w = solve_for_w(B, b)
    w = [];
    for i = 1:size(B, 1)
        w(i) = 1 / B(i, i) * (b(i) - sum(B(i, 1:i-1) .* w(1:i-1)));
    end
end

% Resuelve el sistema triangular superior Bu = w.
% Precondicion: length(b) = size(B, 1).
function u = solve_for_u(B, w)
    u = [];
    for i = size(B, 1):-1:1
        u(i) = 1 / B(i, i) * (w(i) - sum(B(i,i+1:end) .* u(i+1:end)));
    end
end