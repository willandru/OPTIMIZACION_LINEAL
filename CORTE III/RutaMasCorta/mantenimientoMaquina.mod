# CONJUNTOS
set I:=1..6; #Años

#PARAMETROS
param C{I}; #Costo de comprar la maquina al inicio del año i
param O{I}; #Costo de operacion de la maquina al i-esimo año de uso
param R{I}; #Valor residual de la maquina en el año i
param B{I,I}; 

#VARIABLES DE DECISION
var X{i in I, j in I} binary; # 1 Si compro la maquina el año i y la vende el año j. 0 si no.

#FUNCION OBJETIVO
minimize z:sum{i in I, j in I:j>i} (C[i]+(sum{k in I:k<=j-i} O[k]) - R[j-i]) * X[i,j];

#RESTRICCIONES
s.t. comprarYearUno: sum{j in I}X[1,j]=1;
s.t. ventaFinalYear5: sum{i in I}X[i,6]=1;
s.t. balance{k in I:k>1 and k<6}:sum{i in I}X[i,k]=sum{j in I}X[k,j];
s.t. variablesCero{i in I, j in I}:X[i,j]<=B[i,j];

#DATOS
data;

param C:=
1	12000
2	13000
3	14000
4	15000
5	16000
6	0;


param O:=
1	2000
2	4000
3	5000
4	9000
5	12000
6	0;

param R:=
1	7000
2	6000
3	2000
4	1000
5	0
6	0;

param B:1	2	3	4	5	6:=
1		0	1	1	1	1	1
2		0	0	1	1	1	1
3		0	0	0	1	1	1
4		0	0	0	0	1	1
5		0	0	0	0	0	1
6		0	0	0	0	0	0;

end;