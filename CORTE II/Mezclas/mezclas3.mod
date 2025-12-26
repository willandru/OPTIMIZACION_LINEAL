#Conjuntos
set I:=1..6; #fondos
set J:=1..3; #categoria
set K:=1..3; #nutrientes

#Parámetros
param p{I}; #precio de accion por fondo
param t{I}; #tasa de retorno
param c{J,I}; #binario de categorias
param cMin{J}; #minimo proporcion de cartera por categoría
param cMax{J}; #máxima proporcion de cartera por categoría

#V.D
var x{I}>=0, integer; #numero de acciones a comprar por categoria

#F.O.
maximize Z: sum{i in I} t[i]*x[i]*p[i];

#Restricciones
s.t. presupuesto:sum{i in I}x[i]*p[i]<=1000000;
s.t. minimoProporcion{j in J}: sum{i in I}c[j,i] * x[i]*p[i] >= cMin[j]*1000000;
s.t. maximoProporcion{j in J}: sum{i in I}c[j,i] * x[i]*p[i] <= cMax[j]*1000000;
s.t. proporcion1: 2*x[1]*p[1]=x[2]*p[2];
s.t. proporcion2: 3*x[1]*p[1]=x[3]*p[3];
s.t. proporcion3: 2*x[4]*p[4]=x[5]*p[5];

#datos
data;

param p:=
1	45
2	76
3	11
4	17
5	23
6	22;

param t:=
1	0.3
2	0.2
3	0.15
4	0.12
5	0.1
6	0.07;

param c:	1	2	3	4	5	6:=
1			1	1	1	0	0	0
2			0	0	0	1	1	0
3			0	0	0	0	0	1;

param cMin:=
1	0.5
2	0.2
3	0.05;

param cMax:=
1	0.75
2	0.3
3	10000;

end;




