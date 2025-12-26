#Conjuntos

set I:=1..3; #Tipo de Columna
set J:=1..4; #Semanas
set K:=1..2; #Tipos de trabajo={TimepoCompleto, TimepoParcial}



#Parametros

param D{I,J}; #Demanda minima de columnas I en la semana J
param P{I}; #Tiempo de trabajo manual minimo para la fabricacion de la culimna I.
param V;
param N{I}; #Inventario minimo de columnas 
param F{I}; #Costo de almacenamiento por tipo de columna I
param S{K}; #Salarios del trabajador tipo K
param T{K}; #Tiempo que trabaja cada empleado K 


#Variables Decision; 

var X{I,J,K}>=0 integer; # Trabajadores contratados en para fabricar la columna I en la semana J con el contrato K.
var Y{I,J}>=0 integer; #Cantidad de columnas I almacenadas en la semana J
var W{I,J}>=0 integer; #Cantidad de columnas tipo I fabricadas en la semana J

#Funcion Objetivo
minimize Z: sum{i in I, j in J, k in K}X[i,j,k]*S[k] + sum{i in I, j in J}Y[i,j]*F[i];  

#Restricciones

s.t. capacidadProduccion{i in I, j in J}:W[i,j]*P[i] / 60 <= sum{k in K}X[i,j,k]*T[k];
s.t. inventarioMinimoAlmacenado{i in I, j in J}:Y[i,j] >= N[i];
s.t. inventarioSemanaInicial{i in I}:Y[i,1]= W[i,1] - D[i,1];
s.t. inventario{i in I, j in J: j>=2}:Y[i,j]=Y[i, j-1] + W[i, j] -D[i, j];
s.t. capacidadBodega{j in J}:sum{i in I}Y[i,j] <= V;
s.t. trabajadoresMinimo20PorcientoTotal{j in J}:sum{i in I}X[i,j,1] >= 0.2*sum{i in I, h in J, k in K}X[i,h,k];


#Datos


data;

param V:=50;

param D:	1	2	3	4:=
1			20	18	21	17
2			20	22	18	25
3			25	23	28	24;

param P:=
1	120
2	60
3	180;

param T:=
1	40
2	20;

param S:=
1	300000
2	200000;

param F:=
1	100
2	200
3	50;

param N:=
1	5
2	10
3	3;

end;