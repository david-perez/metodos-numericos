disp('Vamos a resolver varios sistemas lineales Au = b, con A una matriz inversible fija, mediante eliminación gaussiana.');
A = square_matrix_loader();
b = vector_loader(size(A, 1), 'b');

[u, A, punt] = eliminacion_gaussiana(A, b);
u

while (true)
    b = input('¿Deseas resolver más sistemas con otro vector b (1/0)?');
    if b == 0
        break;
    end
    b = vector_loader(size(A, 1), 'b');
    u = eliminacion_gaussiana(A, b, punt);
    u
end