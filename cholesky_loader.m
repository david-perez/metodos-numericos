disp('Vamos a resolver varios sistemas lineales Au = b, con A una matriz inversible fija, mediante su factorización de Cholesky.');
A = square_matrix_loader();
b = vector_loader(size(A, 1), 'b');

[u, A] = cholesky(A, b);
u

while (true)
    b = input('¿Deseas resolver más sistemas con otro vector b (1/0)?');
    if b == 0
        break;
    end
    b = vector_loader(size(A, 1), 'b');
    u = cholesky(A, b);
    u
end