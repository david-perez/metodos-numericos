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
            s = A(i,1:i-1) * A(i,1:i-1)';
        
            if A(i, i) <= s
                disp('La matriz A no admite factorización de Cholesky.')
                return;
            end
            A(i, i) = sqrt(A(i, i) - s);
        
            for j = i+1:n
                A(j, i) = 1 / A(i,i) * (A(i, j) - A(i,1:i-1) * A(j,1:i-1)');
            end
        end
    end
    
    % La parte triangular inferior de A contiene B
    w = solve_for_w(A, b);
    u = solve_for_u(A', w);
end

% Resuelve el sistema triangular inferior Lw = b.
% Precondición: length(b) = size(A, 1).
function w = solve_for_w(A, b)
    for i = 1:size(A, 1)
        w(i) = b(i);
        for j = 1:i-1
            w(i) = w(i) - A(i, j) * w(j);
        end
        w(i) = w(i) / A(i, i);
    end
end

% Resuelve el sistema triangular superior Uu = w.
% La parte triangular superior de A almacena U.
% Precondicion: length(b) = size(A, 1).
function u = solve_for_u(A, w)
    for i = size(A, 1):-1:1
        s = 0;
        for j = i+1:size(A, 1)
            s = s + A(i, j) * u(j);
        end
        u(i) = (w(i) - s) / A(i, i);
    end
end

% Resuelve el sistema triangular inferior Bw = b.
% Precondición: length(b) = size(B, 1).
% Es más eficiente que solve_for_w pero solamente funciona en MATLAB.
function w = solve_for_w2(B, b)
    w = zeros(size(B, 1), 1); % Dynamic resizing debería ser amortized O(1) si lo programaron bien, pero por si acaso...
    for i = 1:size(B, 1)
        w(i) = 1 / B(i, i) * (b(i) - B(i, 1:i-1) * w(1:i-1));
    end
end

% Resuelve el sistema triangular superior Bu = w.
% Precondicion: length(b) = size(B, 1).
% Es más eficiente que solve_for_u pero solamente funciona en MATLAB.
function u = solve_for_u2(B, w)
    u = zeros(size(B, 1), 1);
    for i = size(B, 1):-1:1
        u(i) = 1 / B(i, i) * (w(i) - B(i,i+1:end) * u(i+1:end));
    end
end