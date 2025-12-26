#Conjuntos
set I:=1..4;
set J:=1..4;
set K:=1..4;

#Parametros
param E{I,J}; #Capacidad de transporte entre el campo I y la refineria J
param L{J,K}; #Capacidad de transporte entre la refineria J y el centro de distribucion K

#Variables de decision

var X{I,J}>=0; #Cantidad de barriles de petorleo a enviar del campo I a la refineria J.
var Y{J,K}>=0; #Cantidad de barriles de petroleo a enviar de la refineria J a el centro de distribucion K.

#Funcion Objetivo
#queremos maximizar la cantidad de barriles que llegan a los Centros de Distribucion
maximize Z: sum{j in J, k in K} Y[j,k];


#Restricciones

s.t. transporteCampoRefineria{i in I, j in J}: X[i,j]<= E[i,j];
s.t. transporteRefineriaCentroDistri{j in J, k in K}: Y[j,k]<= L[j,k];
s.t. noAlmacenamientoRefineria{j in J}:sum{i in I}X[i,j]=sum{k in K}Y[j,k];
#Datos

data;

param E:	1	2	3	4:=
1			11	7 	2 	8
2			5	4	8	7
3			7	3	12	6
4			8	9	4	15;

param L:	1	2	3	4:=
1			5	9	6	4
2			8	7	9	5
3			4	6	7	8
4			12	11	9	7;

end;