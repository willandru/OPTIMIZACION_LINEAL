

#CONJUNTOS

set I:=1..4; # BARCOS ={1:Laurier, 2:Mackenzie, 3:Skidegate, 4:SimonFraser}
set J:=1..10; # DISTRITOS ={1, ..., 10}


#PARAMETROS


param T{I,J}; #Numero de semanas que le toma a un barco I atender un distrito J
param C{I,J}; #Costo de asignar un barco I a el distrito J
param S; #Semanas maximas que esta disponible cada barco


#VARIABELS DE DECISION

var X{I,J} binary; #Barcos I que estan disponibles para servir a el distritos J


#FO

minimize Z: sum{i in I, j in J} X[i,j]*C[i,j];
#RESTRICCIONES

s.t. cadaDistritoUnoDeLosBarcos{j in J}: sum{i in I}X[i,j]=1;
s.t. tiempoMaxdeCadaBarco{i in I}:sum{j in J}X[i,j]*T[i,j] <= S;


#DATOS


data;

param T:	1	2	3	4	5	6	7	8	9	10:=
1			30	50	10	23	12	21	16	25	7	25
2			11	13	9	15	40	24	23	36	21	35
3			10	20	60	33	24	34	24	17	34	34
4			20	10	10	10	17	39	13	20	38	36;

param C:	1	2	3	4	5	6	7	8	9	10:=
1			 130	30	 510	 270	 40 	 90 	 60 	220 	280 	300
2			 30 	340 	20	 50 	120 	150 	260 	90	70	 200
3			 460	 150	 20 	180 	60	80	 130	 220	 310	 90
4			 40 	370 	120 	160 	270 	140 	210 	140 	120 	60;

param S:=50;

end;