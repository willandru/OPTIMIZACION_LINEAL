#CONJUNTOS

set I:=1..14; # MISIONES POSIBLES ={1, ... , 14}
set J:=1..5; #ETAPAS



#PARAMETROS


param P{J}; #Presupuesto de la etapa J
param F{I,J}; #Inversion de la mision I en la etapa J
param G{I}; #Ganancia intelectual de la etapa I



#VARIABELS DE DECISION

var X{I} binary; #Se realiza o No la mision I


#FO

maximize Z: sum{i in I}X[i]*G[i];

#RESTRICCIONES

s.t. siUnaMisionEntTodasLasEtapas:
s.t. si4No5: X[4] + X[5] <=1;
s.t. si5Entonces3: X[5] <= X[3];
s.t. si1y8EntoncesNo3: X[1] + X[8] + X[3] <= 2;
s.t. si5o7Entonces6: X[5] + X[7] <= 2*X[6];
s.t. si1o2Entonces14: X[1]+ X[2] <= 2*X[14];
s.t. si7Entonces11y13Parte1: X[7] <= X[11];
s.t. si7Entonces11y13Parte2: X[7] <= X[13];
s.t. presupuestoEtapa{j in J}:sum{i in I}X[i]*R[i,j]<=P[j];

#DATOS


data;

param R:	1	2	3	4	5:=
1	6	99	99	99	99
2	2	3	99	99	99
3	3	5	99	99	99
4	99	99	99	99	10
5	99	5	8	99	99
6	99	99	1	8	4
7	1	8	99	99	99
8	99	99	99	5	99
9	4	5	99	99	99
10	99	8	4	99	99
11	99	99	2	7	99
12	5	7	99	99	99
13	99	1	4	1	1
14	99	4	5	3	3;

param P:=
1	10
2	12
3	14
4	14
5	14;

param B:=
1	200
2	3
3	20
4	50
5	70
6	20
7	5
8	10
9	200
10	150
11	18
12	8
13	300
14	185;

end;