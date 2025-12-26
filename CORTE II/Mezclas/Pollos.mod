#Conjuntos
set I:=1..4; # Semanas
set J:=1..3; # Ingredientes {caliza, maiz, soya}
set K:=1..3; #Nutrientes {calcio, proteina, fibra}

#Parametros
param A{I}; # Alimento requerido semanalmente
param Q{J,K}; # Contenido de nutrientes K en ingrediente J
param C{J}; # Costo de cada ingrediente J
param Ni{K}; # Porcentaje minimo de nutrientes 
param Na{K}; #Porcentaje maximo de nutrientes

#Variables de Decision
var X{I,J} >=0;  # Cantidad (libras) de ingrediente J en la semana I


#Funcion Objetivo
minimize Z: sum{i in I, j in J}X[i,j]*C[j];

#Restricciones
s.t. CantidadSemanalAlimento{i in I}:sum{j in J}X[i,j]=A[i];
s.t. CantiMinimaNutrientes{i in I, k in K}:sum{j in J} X[i,j] * Q[j,k] >= Ni[k] * sum{j in J} X[i,j];
s.t. CantiMaxNutrientes{i in I, k in K}: sum{j in J} X[i,j] * Q[j,k] <= Na[k] * sum{j in J} X[i,j];


data;

param A:=
1	0.26
2	0.48
3	0.75
4	1;

param Q:	1	2	3:=
1			0.380 	0 	0
2			0.001 	0.09 	0.02
3			0.002 	0.50 	0.08;

param C:=
1	0.12
2	0.45
3	1.60;

param Ni:=
1	0.008
2	0.22
3	0;

param Na:=
1	0.012
2	1
3	0.05;

end;