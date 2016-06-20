disp('Vamos a resolver un sistema tridiagonal Ax = d');
A = square_matrix_loader();

n = size(A, 1);

disp(['a es la subdiagonal de A (la diagonal por debajo de la diagonal principal). Tiene ', num2str(n-1), ' componentes.']);
a = vector_loader(size(A, 1) - 1, 'a');

disp(['c es la superdiagonal de A (la diagonal por encima de la diagonal principal). Tiene ', num2str(n-1), ' componentes.']);
c = vector_loader(size(A, 1) - 1, 'c');

disp(['b es la diagonal de A. Tiene ', num2str(n), ' componentes.']);
b = vector_loader(size(A, 1), 'b');

disp(['d es el vector de términos independientes. Tiene ', num2str(n), ' componentes.']);
d = vector_loader(size(A, 1), 'd');

x = tridiagonal2(a, b, c, d);
x