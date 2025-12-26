
#CONJUNTOS

set I:=1..7; # CONCIERTOS  ={ 1: AE, 2:PJ,  3:RS , 4:EC , 5:GR , 6:JB, 7:MA}
set J:=1..3; # TIPO ENTRADA ={1:Andes, 2:Cancha, 3:Galeria}


#PARAMETROS

param C{I,J}; #Costo de las entradas J para los conciertos I
param B{I,J}; #Beneficios de cada entrada J para cada concierto I
param P; #Presupuesto máximo

#VARIABELS DE DECISION

var X{I,J} binary; # 1 si se asiste al concierto I con la entrada J, 0 si no.

var Y >=0;

#fo

maximize Z: sum{i in I, j in J}X[i,j]*B[i,j] ;

#RESTRICCIONES

s.t. asistirAEoPJ: sum{j in J} X[1,j] + sum{j in J} X[2,j] >= 1;
s.t. noAsisteAmbosRSyEC: sum{j in J} X[3,j] + sum{j in J} X[4,j] <= 1;
s.t. siAsistirGR: sum{j in J} X[5,j] >= 1;
s.t. noAsistirJB: sum{j in J} X[6,j] = 0;
s.t. maximo1EntraConcierto{i in I}:sum{j in J}X[i,j]<=1;
s.t. definirCostoTotal: Y = sum{i in I, j in J} X[i,j] * C[i,j];
s.t. presupuestoMaximo: Y <= P;

#DATOS


data;

param C:	1	2	3:=
1			45000	32000	25000
2			55000	35000	28000
3			55000	35000	25000
4			50000	26000	18000
5			50000	38000	28000
6			56000	27000	16000
7			70000	72000	36000;

param B:	1	2	3:=
1			4	4	9
2			9	3	7
3			6	2	3
4			1	1	6
5			5	10	4
6			5	6	7
7			8	7	5;

param P:= 200000;

end;