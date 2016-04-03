function [u, A] = factorizacion_LU(A, b)
    n = size(A, 1);
    if size(A, 2) ~= n
        disp('La matriz A no es cuadrada.')
        return;
    end
    if length(b) ~= n
        disp('El vector b no tiene el mismo número de filas que la matriz A.')
        return;
    end
    
    if nargout == 2 % Calcular LU primero
        for i = 1:n
            % Calcular la fila i-éisma de U.
            A(i, i) = A(i, i) - A(i, 1:i-1) * A(1:i-1, i);
            if A(i, i) == 0
                disp('La matriz A no admite factorización LU.')
                u = 0;
                return;
            end
            for j = i+1:n
                A(i, j) = A(i, j) - A(i, 1:i-1) * A(1:i-1, j);
            end
        
            % Calcular la columna i-ésima de L.
            for j = i+1:n
                A(j, i) = 1/A(i, i) * (A(j, i) - A(j, 1:i-1) * A(1:i-1, i));
            end
        end
    end
    
    % A contiene la parte inferior de L (la diagonal de L son unos).
    % La parte triangular superior de A almacena U.
    w = solve_for_w(A, b);
    u = solve_for_u(A, w);
    
%     Debug purposes
%     for i = 1:n
%         for j = 1:i-1
%             L(i, j) = A(i, j);
%         end
%         L(i, i) = 1;
%     end
%     
%     for i = 1:n
%         for j = i:n
%             U(i, j) = A(i, j);
%         end
%     end
    
end

% Resuelve el sistema triangular inferior Lw = b.
% A contiene la parte inferior de L (la diagonal de L son unos).
% Precondición: length(b) = size(A, 1).
function w = solve_for_w(A, b)
    for i = 1:size(A, 1)
        w(i) = b(i);
        for j = 1:i-1
            w(i) = w(i) - A(i, j) * w(j);
        end
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