Prácticas de programación de Métodos Númericos en `MATLAB`
===================

Aquí se documenta una colección de scripts en `MATLAB` cuya funcionalidad es la siguiente:

 - Resolución de sistemas lineales $Au = b$ mediante eliminación gaussiana (`eliminacion_gaussiana.m`).
 - Resolución de sistemas lineales $Au = b$ mediante el cálculo de la factorización $A = LU$ de una matriz (`factorizacion_LU.m`).
 - Resolución de sistemas lineales $Au = b$ mediante el cálculo de la factorización $A = BB^T$ de Cholesky de una matriz (`cholesky.m`).
 - Resolución de sistemas lineales tridiagonales $Ax = d$ (`tridiagonal.m`, `tridiagonal2.m`).
 - Resolución de sistemas lineales mediante el método de Jacobi (`jacobi.m`).
 - Resolución de sistemas lineales mediante el método de relajación (`relajacion.m`).
 - Cálculo del polinomio de interpolación de Lagrange de una función por unos puntos dados, mediante la fórmula de Newton (`lagrange_newton.m`).
 - Cálculo de funciones spline cúbicas interpoladoras de tipos I y II que aproximen una función por unos puntos dados (`spline.m`).

Los algoritmos en cuestión se encuentran en los archivos citados arriba, y cada uno viene acompañado de un script, cuyo nombre es el mismo que el del archivo al que acompaña seguido del sufijo `_loader`, que provee al usuario de una interfaz por consola que pedirá los datos para la correcta ejecución de los algoritmos.

Por ejemplo, si uno sabe ya que la función `factorizacion_LU(A, b)` toma como argumentos de entrada una matriz cuadrada y un vector, puede ejecutar

```
--> factorizacion_LU(A, b) 
```

pasándole directamente los datos, o bien ejecutar:

```
--> factorizacion_LU_loader()
```

sin ningún argumento, y una interfaz por consola pedirá al usuario que introduzca las entradas de la matriz $A$ y el vector $b$.

----------

> **Nota:**

> - En los métodos de Jacobi y de relajación, no se comprueba que el sistema tenga solución (i.e. que $A$ sea inversible), ni que el método iterativo asociado converja. Se puede especificar la precisión deseada con la que se debe calcular una solución y un número máximo de iteraciones. El algoritmo indicará por cuál de las dos razones éste para.
> - La única diferencia entre `tridiagonal.m` y `tridiagonal2.m`, es que el primer script pide la matriz tridiagonal en cuestión, mientras que el segundo recibe como argumentos las componentes diagonales de la matriz. Este segundo método es preferible ante matrices tridiagonales de dimensión elevada, pues serán inherentemente "sparse".
> - Solamente `tridiagonal2.m` cuenta con una interfaz por consola `tridiagonal2_loader.m`.
> - Todos los scripts han sido probados en `FreeMat v4.2`. En algunos casos hay funciones comentadas, que solamente funcionan en `MATLAB`, y que son ligeramente más eficientes al vectorizar los datos de entrada.