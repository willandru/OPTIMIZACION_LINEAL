

#CONJUNTOS

set I:=1..10; # SISTIOS DE CONSTRUCCION ={1, ..., 10}
set J:=1..5; # AÑOS ={1, ..., 5}


#PARAMETROS

param B{I}; #Ingreso potencial del sitio I
param R{I,J}; #Inversion requerida en el sitio I por cada año J
param P{J}; #Presupuesto anual maximo por cada año I


#VARIABELS DE DECISION

var X{I} binary; # 1 si se construye en la superficie I , 0 si no.

#FO

maximize Z:sum{i in I}B[i]*X[i];

#RESTRICCIONES
s.t. presupeustoMaximoAnual{j in J}:sum{i in I}R[i,j]*X[i]<=P[j];
s.t. si9entonces2y5: 2* X[9] <= X[2]+ X[5];
# s.t. condicion1parte1: X[9]<=X[2];
# s.t. condicion1parte2: X[9]<=X[5];
s.t. si4y6entoncesNo10: X[4]+X[6] <=2-X[10];
s.t. ambosOninguno1y2: X[1] = X[2] ;


#DATOS


data;

param B:=
1	20
2	70
3	20
4	50
5	50
6	70
7	80
8	10
9	90
10	90;

param P:=
1	30
2	30
3	35
4	28
5	31;


param R:	1	2	3	4	5:=
1	2	4	5	5	4
2	7	7	8	7	6
3	3	4	3	4	2
4	8	5	8	6	7
5	5	3	3	4	4
6	11	11	8	7	11
7	8	6	10	7	9
8	3	3	2	1	1
9	7	9	9	5	5
10	8	11	10	8	9;



end;