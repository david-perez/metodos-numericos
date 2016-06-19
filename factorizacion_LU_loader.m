disp('Vamos a resolver varios sistemas lineales Au = b, con A una matriz inversible fija, mediante su factorizacion LU.');
A = square_matrix_loader();
b = vector_loader(size(A, 1), 'b');

[u, A] = factorizacion_LU(A, b);
u

while (true)
    b = input('¿Deseas resolver más sistemas con otro vector b (1/0)?');
    if b == 0
        break;
    end
    b = vector_loader(size(A, 1), 'b');
    u = factorizacion_LU(A, b);
    u
end