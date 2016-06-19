function A = square_matrix_loader
    n = input('Dimensión de la matriz A:');
    
    A = zeros(n, n);
    for i = 1:n
        for j = 1:n
            m = ['A(', num2str(i), ',', num2str(j), '):'];
            A(i, j) = input(m);
        end
    end            
end