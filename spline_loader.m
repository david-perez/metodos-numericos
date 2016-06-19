disp('Vamos a plottear una funci�n en un intervalo [a, b], junto con una funci�n spline c�bica interpoladora.');
astr = input('Valor de a: ');
bstr = input('Valor de b: ');
eval('a = astr;');
eval('b = bstr;');
x = linspace(a, b);

fstr = input('Introduce una funci�n en la variable x tal y como te la devolver�a MATLAB tras pasarla por vectorize():', 's');
y = eval(fstr);
eval(['f = @(x) ', fstr]);

n = input('Introduce el n�mero de puntos (que estar�n equiespaciados en [a, b]) para el c�lculo de la funci�n spline c�bica: ');
h = (b - a) / n;
n = n + 1; % Para que pinte b.

p = a;
T = zeros(n, 2);
for i = 1:n
    T(i, 1) = p;
    T(i, 2) = f(p);
    p = p + h;
end

t = input('Tipo de la funci�n spline (1 o 2):');

if (t == 2)
    yp0 = input('Valor de la derivada en a:');
    ypn = input('Valor de la derivada en b:');
    
    hold on
    spline(T, t, 0, yp0, ypn);
else
    hold on
    spline(T, t, 0);
end

plot(x, y);
hold off