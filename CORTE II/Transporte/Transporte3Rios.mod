# Conjuntos

set I:=1..3; # Rios
set J:=1..3; #Primeros puntos intermedios
set K:=1..3; #Segundos puntos intermedios
set T:=1..1; #Ciduadd de llegada


#Parametros
param R{I,J}; #Capacidad de transporte entre los rios y los primeros nodos
param Q{J,K}; #Capacidad de transporte entre los primeros nodos y los segundos nodos
param B{K,T}; #Capacidad de transporte entre los segundos nodos y la ciudad final

#Variables de decision
var X{I,J} >=0; #Cantidad enviada entre los rios I y los nodos J
var Y{J,K} >=0; #Cantidad enviada entre los nodos J y los nodos K
var W{K,T} >=0; #Cantidad enviada entre los nodos K y el nodo T

#Funcion Objetivo

maximize Z:sum{k in K, t in T}W[k,t];

#Restricciones

s.t. cantMaxdeIaJ{i in I, j in J}:X[i,j]<=R[i,j];
s.t. cantMaxdeJaK{j in J, k in K}:Y[j,k]<=Q[j,k];
s.t. cantMaxdeKaT{k in K, t in T}:W[k,t]<=B[k,t];
s.t. noAlmacenamientoJ{j in J}:sum{i in I} X[i,j] = sum{k in K} Y[j,k];
s.t. noAlmacenamientoK{k in K}:sum{j in J} Y[j,k] = W[k,1];



#Datos

data;

param R:	1	2	3:=
1			130 	115 	0
2			70  	90  	110
3			0   	140 	120;

param Q:	1	2	3:=
1			110 	85  	0
2			130 	95  	85
3			0   	130 	160;

param B:	1:=
1	220
2	330
3	240;

end;
