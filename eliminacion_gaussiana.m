function u = eliminacion_gaussiana(A, b)
    n = size(A, 1);
    if size(A, 2) ~= n
        disp('La matriz A no es cuadrada.')
        return;
    end
    if length(b) ~= n
        disp('El vector b no tiene el mismo número de filas que la matriz A.')
        return;
    end
    
    punt = [1:n];
    
    for k = 1:n-1
        % Permutar filas.
        r = select_pivot_row(A, k, punt);
        if r == -1
            disp('La matriz A no es inversible.')
            return;
        end
        punt([k, r]) = punt([r, k]); % intercambia punt(k) con punt(r).
        
        for i = k+1:n
            A(punt(i), k) = A(punt(i),k) / A(punt(k), k);
            for j = k+1:n
                A(punt(i), j) = A(punt(i), j) - A(punt(i), k) * A(punt(k), j);
            end
        end
        
        % read(A, punt)
    end
    
    % Puede suceder que en la etapa n-1 ésima aparezca un 0 en U(n, n) en cuyo caso
    % A no era inversible.
    if A(punt(n), n) == 0 
        disp('La matriz A no es inversible.')
        return;
    end
    
    w = solve_for_w(A, b, punt);
    u = solve_for_u(A, w, punt);
end

% Devuelve el número de la fila de la que se selecciona el pivote de la columna k de A
% según la estrategia del pivote parcial.
% Devuelve -1 si la columna k es nula por debajo de la fila k i.e. A no es inversible.
% Precondición: 1 <= k <= size(A, 1).
function p = select_pivot_row(A, k, punt)
    p = k;
    m = abs(A(punt(k), k));
    for i = k+1:size(A, 1)
        if abs(A(punt(i), k)) > m
            m = abs(A(punt(i), k));
            p = i;
        end
    end
    if m == 0
        p = -1;
    end
end

% Devuelve una matriz Ap, que es A leída en el orden que marcan las permutaciones almacenadas en punt.
% Precondicion: length(punt) = size(A, 1).
function Ap = read(A, punt)
    for i = 1:size(A, 1)
        Ap(i, :) = A(punt(i), :);
    end
end

% Resuelve el sistema triangular inferior Lw = Pb.
% Las permutaciones P estan almacenadas en punt.
% A contiene la parte inferior de L (la diagonal de L son unos).
% Precondicion: length(punt) = size(A, 1).
function w = solve_for_w(A, b, punt)
    for i = 1:size(A, 1)
        w(i) = b(punt(i));
        for j = 1:i-1
            w(i) = w(i) - A(punt(i), j) * w(j);
        end
    end
end

% Resuelve el sistema triangular superior Uu = w.
% Las permutaciones P estan almacenadas en punt.
% La parte triangular superior de A almacena U.
% Precondicion: length(punt) = size(A, 1).
function u = solve_for_u(A, w, punt)
    for i = size(A, 1):-1:1
        s = 0;
        for j = i+1:size(A, 1)
            s = s + A(punt(i), j) * u(j);
        end
        u(i) = (w(i) - s) / A(punt(i), i);
    end
end