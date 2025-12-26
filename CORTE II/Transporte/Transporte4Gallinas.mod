# Conjuntos

set I:=1..3; # Silos
set J:=1..4; #Granjas intermedias
set K:=1..4; #Granjas Finales


#Parametros
param A{I}; # Capacidad de abastecimiento de comida en los silos I
param D{K}; # Demandas de alimento de las granjas K
param C{I,J}; #Costos de envio de los Silos I a las granjas J.
param CC{J,K}; #Costos de envio de las granjas J a las granjas K
param T{I,J}; #Capacidad de transporte de los silos I a las granjas J.
param TT{J,K}; #Capacidad de transporte de las granjas J a las granajs K.

#Variables de decision
var X{I,J} >=0; # Cantidad enviada de los Silos I a las granjas J
var Y{I,J,K}>=0; #Cantidad a enviar de los Silos I a las granjas de trasbordo J hasta las granjas K
var W{K}>=0; #Cantidad de demanda que no llega a las granjas K


#Funcion Objetivo

minimize Z:
    sum{i in I, j in J} X[i,j]*C[i,j] +
    sum{i in I, j in J, k in K} Y[i,j,k]*CC[j,k] +
    1000*sum{k in K} W[k];

#Restricciones

s.t. cantMaxdeSilosaGranjas{i in I, j in J}:X[i,j]<=T[i,j];
s.t. cantMaxdeGranjasJaGranjasK{i in I, j in J, k in K}:Y[i,j,k] <= TT[j,k];
s.t. ofertaAlimentoSilos{i in I}:sum{j in J}X[i,j]<=A[i];

s.t. flujoGranjasIntermedias{j in J}:sum{i in I, k in K} Y[i,j,k] <= sum{i in I} X[i,j];
s.t. demandaAlimentoGranja{k in K}:sum{i in I, j in J} Y[i,j,k] + W[k] = D[k];






#Datos

data;

param C:	1	2	3	4:=
1			5	4	9999	3
2			9999	9999	5	7
3			2	6	2	3;

param CC:	1	2	3	4:=
1			9999	3	9999	9999
2			5	9999	10	9999
3			9999	11	9999	8
4			9999	9999	9	9999;

param A:=
1	20
2	20
3	200;

param D:=
1	200
2	10
3	60
4	20;

param T:	1	2	3	4:=
1			30	5	0	40
2			0	0	5	90
3			10	40	30	40;

param TT:	1	2	3	4:=
1			0	50	0	0
2			50	0	50	0
3			0	50	0	50
4			0	0	50	0;




end;
