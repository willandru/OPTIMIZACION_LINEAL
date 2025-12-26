#Conjuntos
set I := 1..9;  #localidad

#Parámetros
param b{I,I};   #1 si la población i en I está a 15 minutos o menos de la localidad j en I
param p{I};     #número de personas que viven en la localidad i;

#Variables de decisión
var x{I} binary;  #1 si se coloca una estación de ambulancias en la localidad i

#Función objetivo
minimize z: sum{i in I} x[i] / sum{j in I} p[j] * b[i,j];

#s.a.
s.t. cubrimiento{j in I}: sum{i in I} b[i,j] * x[i] >= 1;

data;

param b: 1 2 3 4 5 6 7 8 9 :=
1 1 0 1 0 1 0 1 0 0
2 0 1 0 1 0 1 0 0 0
3 1 0 1 0 1 0 0 1 1
4 0 1 0 1 0 0 1 0 0
5 1 0 0 1 0 1 0 0 0
6 0 1 0 1 0 1 0 1 0
7 1 0 1 0 0 1 0 0 0
8 0 0 1 0 1 0 1 0 1
9 0 0 1 0 0 0 0 1 1;

param p :=
1 15000
2 16000
3 25000
4 32000
5 12000
6 45000
7 55000
8 42000
9 20000;

end data;
