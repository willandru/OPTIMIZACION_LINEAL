#Conjuntos

set I:=1..5; # Tipos de articulos 

#Parametros

param K{I}; #Peso del articulo I
param V{I}; #Volumen del articulo I
param G{I}; #Ganancia del articulo I
param Q{I}; #Cantidad disponible del articulo I
param Pmax; #Peso maximo permisible
param Vmax; #Volumen maximo permisible

#Variables de Decision
var X{I} >=0 integer; # Cantidad de articulos del tipo I 
var P >= 0, <= 1;  

#Funcion Objetivo
maximize Z:sum{i in I}X[i]*G[i];

#Restricciones

s.t. pesoMaximo:sum{i in I}X[i]*K[i] <= Pmax;
s.t. volMaximo:sum{i in I}X[i]*V[i] <= Vmax;
s.t. proporcion{i in I}: X[i]= P * Q[i];

#Datos

data;

param Pmax:=11200;

param Vmax:=10900;

param K:=
1	5
2	8
3	3
4	2
5	7;

param V:=
1	1
2	8
3	6
4	5
5	4;

param G:=
1	4
2	7
3	6
4	5
5	4;

param Q:=
1	300
2	500
3	1000
4	800
5	400;

end;




