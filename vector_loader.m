function v = vector_loader(n, u, f)
    % f == 1 para que devuelva un vector fila en vez de un vector columna.
    v = zeros(n, 1);
    for i = 1:n
        m = [u, '(', num2str(i), '):'];
        v(i) = input(m);
    end
    
    if nargin == 3 && f == 1
        v = v';
    end
end