#Conjuntos
set I:=1..2; #Lineas de produccion
set J:=1..3; #Productos
set K:=1..6; #Meses

#Parametros
param D{J,K}; #Demanda del producto J en el mes K
param Cr{J}; #Costo de retencion unitaria del prooducto J
param Io{J}; #Inventario incial del producto J
param P{I,J}; #Capacidad de produccion del producto J en la linea I
param C{I,J}; #Costo de produccion del producto J en la linea I
param V; #Capacaidad de la bodega
param Vp{J}; #Volumen de cada producto J

#Variables de Decision

var X{I,J,K}>=0 ; #Cantidad de pruductos tipo J a producir en la linea I durante el mes K
var Y{J,K}>=0 ; #Cantidad de productos tipo J a almacenar en el mes K

#Funcion Objetivo
minimize Z:sum{i in I, j in J, k in K}X[i,j,k]*C[i,j] + sum{j in J, k in K}Y[j,k]*Cr[j];

#Restricciones

s.t. capacidadProduccion{i in I, k in K}:sum{j in J}X[i,j,k]/P[i,j] <= 1 ;
s.t. capacidadVolumenBodega{k in K}:sum{j in J}Y[j,k]*Vp[j] <= V;
s.t. Inventario_inicial {j in J}: Y[j,1] = Io[j] + sum {i in I} X[i,j,1] - D[j,1];
s.t. inventario{j in J, k in K: k > 1}: Y[j,k] = Y[j,k-1] + sum {i in I} X[i,j,k] - D[j,k];



#Datos
data;

param D:	1	2	3	4	5	6:=
1			50	30	40	60	20	45
2			40	60	50	30	30	55
3			30	40	20	70	40	30;

param P:	1	2	3:=
1			40	60	80
2			90	70	60;

param C:	1	2	3:=
1			10	8	15
2			12	6	10;

param Cr:=
1	0.5
2	0.35
3	0.45;

param Io:=
1	55
2	75
3	60;

param V:=1000;

param Vp:=
1	0.2
2	0.11
3	0.16;


end;