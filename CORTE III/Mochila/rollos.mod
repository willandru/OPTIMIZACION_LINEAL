

#CONJUNTOS

set I:=1..50; #TIPO DE ROLLO
set J:=1..4; # ROLLOS 




#PARAMETROS


param T{J}; #Tamaño del tipo de royo I
param Q{I}; #Cantidad solicitada del tipo de royo I


#VARIABELS DE DECISION

var X{I,J} >=0 integer;
var Y{I} binary;


#FO

minimize Z:sum{ i in I} Y[i];

#RESTRICCIONES

s.t. tamaMaxRollo{i in I}:sum{j in J}X[i,j]*T[j]<=100*Y[i];
s.t. suplirDemanda{j in J}:sum{i in I}X[i,j]>=Q[j];


#DATOS


data;

param T:=
1	20
2	50
3	70
4	100;

param Q:=
1	10
2	15
3	18
4	2;

end;