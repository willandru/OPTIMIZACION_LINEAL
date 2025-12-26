#CONJUNTOS

set I := 1..8;  #Tipos de Transmisores
set J := 1..16;  # Localidades

#PARAMETROS
param M;     #Presupuesto máximo
param C{I};     #Costo de construccion del transmisor I
param T{I,J};   #Transmisor I que cubre las localidades J
param P{J};  #Poblacion de las localidades J



#VARIABLES DE DECISION
var X{I} binary;


#PARAMETRO AUXILIAR: poblacion cubierta por cada transmisor
param Pcovered{i in I} := sum{j in J} P[j]*T[i,j];


#FUNCION OBJETIVO: maximizar poblacion cubierta
maximize minimize: sum{i in I} X[i] ;


#RESTRICCIONES
s.t. presupuestoMaximo:sum{i in I}X[i]*C[i]<=M;

#DATOS


data;

param M:=20;

param C:=
1	3.6
2	2.3
3	4.1
4	3.15
5	2.8
6	2.65
7	3.1
8	4;

param P:=
1	10
2	15
3	28
4	30
5	40
6	30
7	20
8	15
9	60
10	12
11	25
12	32
13	12
14	15
15	45
16	35;

param T: 
   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 :=
1  1  1  0  0  0  0  0  0  0  0  0  0  1  0  0  1
2  0  1  1  0  1  0  0  0  0  0  0  0  0  0  1  0
3  1  0  0  0  0  0  1  0  1  1  0  0  0  0  0  0
4  0  0  0  1  0  1  0  1  1  0  0  0  0  0  0  1
5  0  0  0  0  0  1  1  0  1  0  1  0  0  0  0  0
6  0  0  0  0  1  0  1  0  0  1  0  1  0  1  0  0
7  0  0  0  0  0  0  0  0  0  0  0  1  1  1  1  0
8  0  0  0  1  0  1  0  0  0  1  0  1  0  0  0  1
;


end;