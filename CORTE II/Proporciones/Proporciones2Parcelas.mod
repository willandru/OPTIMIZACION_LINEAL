#Conjuntos

set I=1..3; # Parcelas
set J=1..3; #Especies={Remolacha, Trigo, Soya}


#Parametros

param T{I}; #Tierra cultivable en [ha]
param A{I}; #Asignacion de agua en [m3]
param C{J}; #Consumo de agua de la especie J en [m3/h]
param Q[J]; #Cuota máxima de hectareas a cultivar la especie J en las 3 parcelas en conjunto. 
param G{J}; #Ganancia neta por la especie J en [$/ha]

#Variables de Decision

var X{I,J}>=0; #Cantidad de hectarias del la Especie J en la parcela I

#Funcion Objetivo


#Restricciones

s.t. tierraCultivableMaxima{i in I}:sum{j in J}X[i,j] <= T[i];
s.t. asignacionAguaMaxima{j in J}:sum{}


#Datos



