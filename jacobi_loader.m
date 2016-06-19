disp('Vamos a resolver un sistema lineal Au = b, con A una matriz inversible, mediante el m�todo de Jacobi.');
A = square_matrix_loader();
b = vector_loader(size(A, 1), 'b');

it = input('N�mero m�ximo de iteraciones:');
p = input('Precisi�n deseada:');

[u, reason] = jacobi(A, b, it, p);

if reason == 1
    disp('Se alcanz� la precisi�n desada.');
else
    disp('Se agot� el n�mero m�ximo de iteraciones.');
end

u