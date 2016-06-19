disp('Vamos a resolver un sistema lineal Au = b, con A una matriz inversible, mediante el método de Jacobi.');
A = square_matrix_loader();
b = vector_loader(size(A, 1), 'b');

it = input('Número máximo de iteraciones:');
p = input('Precisión deseada:');

[u, reason] = jacobi(A, b, it, p);

if reason == 1
    disp('Se alcanzó la precisión desada.');
else
    disp('Se agotó el número máximo de iteraciones.');
end

u