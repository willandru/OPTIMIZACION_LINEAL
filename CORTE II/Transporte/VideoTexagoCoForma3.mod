#Conjuntos
set N:=1..12;

#Parametros
param D{N,N}; #Capacidad de transporte entre el nodo n a el nodo m


#Variables de decision

var W{I,J,K}>=0; #Cantidad de barriles de petorleo a enviar del campo I a la refineria J hasta el centro de distribucion K.


#Funcion Objetivo
#queremos maximizar la cantidad de barriles que llegan a los Centros de Distribucion
maximize Z: sum{i in I, j in J, k in K} W[i,j,k];


#Restricciones

s.t. transporteCampoRefineria{i in I, j in J}: sum{k in K}W[i,j,k]<= E[i,j];
s.t. transporteRefineriaCentroDistri{j in J, k in K}:sum{i in I} W[i,j,k]<= L[j,k];

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

param D:	1	2	3	4	5	6	7	8	9	10	11	12:=
1												0	0	0	0	0	0	

end;