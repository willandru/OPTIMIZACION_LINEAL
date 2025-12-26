# Conjuntos
set I:=1..3; # PRCELAS
set J:=1..3; #ESPECIES

# Parametros
param T{I}; # Tierra maxima por parcela
param A{I}; # Agua maxima por parcela
param C{J}; #Agua por cultivo
param H{J}; # Cuota maxima de tierra por tipo de cultivo
param G{J}; # Ganancias

#Variables de Descicion
var x{I,J} >= 0 integer; # Numwro de hectarias cultivadas en la parcela I del cultivo J


#Funcion Objetivo
maximize Z: sum{i in I, j in J}x[i,j]*G[j]; 

#Restricciones
s.t. RestriccionTierraParcela{i in I}:sum{j in J}x[i,j]<=T[i];
s.t. RestriccionAguaParcela{i in I}:sum{j in J}x[i,j]*C[j]<= A[i];
s.t. RestriccionMaxHectporPar{j in J}:sum{i in I}x[i,j] <=H[j];
s.t. RestriccionProporcion {i in I, n in I: i!=n}:sum{j in J}x[i,j]/T[i] = sum{j in J}x[n,j]/T[n];
s.t. RestriccionesNaturales {i in I, j in J}:x[i,j]>=0 ;

data;

param T:=
1	400
2	600
3	300;

param A:=
1	600
2	800
3	375;

param C:=
1	3
2	2
3	1;

param H:=
1	600
2	500
3	325;

param G:=
1	400
2	300
3	100;

end;
