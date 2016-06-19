disp('Vamos a plottear una función en un intervalo [a, b], junto con su polinomio de interpolación.');
astr = input('Valor de a: ');
bstr = input('Valor de b: ');
eval('a = astr;');
eval('b = bstr;');
x = linspace(a, b);

fstr = input('Introduce una función en la variable x tal y como te la devolvería MATLAB tras pasarla por vectorize():', 's');
y = eval(fstr);
eval(['f = @(x) ', fstr]);

n = input('Introduce el número de puntos (que estarán equiespaciados en [a, b]) para el cálculo del polinomio de interpolación: ');
h = (b - a) / n;
n = n + 1; % Para que pinte b.

p = a;
T = zeros(n, 2);
for i = 1:n
    T(i, 1) = p;
    T(i, 2) = f(p);
    p = p + h;
end    

hold on
lagrange_newton(T);
plot(x, y);
hold off

while (true) % MATLAB no tiene do-whiles.
    b = input('¿Deseas añadir otro punto de interpolación (1/0)?:');
    if (b == 1)
        x = input('Coordenada x del punto:');
        T2 = [x f(x)];
        T = [T; T2]; % Concatenar verticalmente la tabla con la nueva fila.
        
        hold on
        lagrange_newton(T);
        plot(x, y);
        hold off
    else
        break;
    end
end