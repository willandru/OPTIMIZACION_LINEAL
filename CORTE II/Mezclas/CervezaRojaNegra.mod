#Conjuntos

set I:=1..2; # Cerveza :{ Negra, Roja}
set J:=1..3; #Ingredientes : {Cebada, Lupulo, Levadura}
set K:=1..3; # Nutrientes : {Proteina, Azucar, Grasa}


#Parametros

param N{J,K}; # Contenido de Nutruientes por litro de ingredientes
param D{I}; # Demanda de cerveza
param Nmax{J}; #Cantidad maxima de nutrientes que se pueden adquirir
param C{J}; # Costo por litro de cada Ingrediente
param Nmin{I,K}; #Unidades minimas de Nutrientes por tipo de Cerveza

#Variables de Decision

var X{I,J} >= 0;  # Cantidad de litros de Ingredientes por tipo de Cerveza

#Funcion Objetivo

minimize Z: sum{i in I, j in J}X[i,j]*C[j];


#Restricciones


s.t. demandaCerveza{i in I}: sum{j in J} X[i,j] >= D[i];
s.t. maxCantIngredientes{j in J}:sum{i in I}X[i,j]<=Nmax[j];
s.t. unidadesMinNutrienteporCerveza{i in I, k in K}: sum{j in J} X[i,j] * N[j,k] >= Nmin[i,k] * sum{j in J} X[i,j]; ## OJO
s.t. cervezaNegravsRoja:sum{j in J} X[1,j] >= 0.5 * sum{j in J} X[2,j];
s.t. levaduraVsLupulo:sum{i in I} X[i,3] <= 0.4 * sum{i in I} X[i,2];
s.t. cebadaMinima:sum{i in I} X[i,1] >= 0.7 * sum{i in I, j in J} X[i,j];

data;

param N:	1	2	3:=
1			125 	320 	50
2			110 	215 	35
3			278 	100 	40;

param D:=
1	1200
2	1500;

param Nmax:=
1	2000
2	860
3	930;

param C:=
1	11
2	7
3	9;

param Nmin: 	1	2	3:=
1	110 	230 	40
2	90  	240 	50;

end;
