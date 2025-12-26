#Conjuntos

set I:=1..4; # Huertas
set J:=1..7; # Detallistas

#Parametros

param D{J}; # Demanda diaria detallistas J
param O{I}; #Oferta en huertas I
param C{I,J}; #Cantidad minima invertida por riesgo J.
param P{J}; #Penalizacion que cobra el detallista J.

#Variables de Decision
var X{I,J}>=0; #Total enviado de la huerta I al detallista J
var Y{I,J}>=0; #Total dejado de enviar de la huerta I al detallista J

#FuncionObjetivo

minimize Z: sum{j in J, i in I}X[i,j]*C[i,j] + sum{j in J, i in I}Y[i,j]*P[j]

#Restricciones


#Datos

data;
param D:=
1	150
2	150
3	400
4	100
5	120
6	80
7	50;

param O:=
1	150
2	200
3	250
4	250;

param C:	1	2	3	4	5	6	7:=
1							1 	0 	3	2 	3 	1	3
2							0 	4 	1	2 	4 	0	2
3							1 	3 	5	0 	5 	2	4
4							5 	6 	2	1 	4 	1	0;

param P:=
1	10
2	20
3	15
4	10
5	20
6	10
7	10;

end;