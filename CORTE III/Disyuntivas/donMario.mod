#CONJUNTOS
set T := 1..7;   #DIAS
set I := 1..15;  #CLIENTES

#PARAMETROS
param W;     #limite diarios sin flete
param C;     #costo fijo flete
param G{T};       #costo unitario sobre W
param F;    #costo de compra diario
param B;    #precio de venta diario
param V{I,T};  #asistencia cliente i dia t
param M; #penalizacion

#VARIABLES DE DECISION
var X{T} >= 0 integer ;    #cantidad de diarios a llevar el dia t
var A{T} binary;          #1 si se debe pagar flete el dia t
var E{T} >= 0 ;    #cantidad de diarios que sobrepasan W el dia t



#FUNCION OBJETIVO
maximize z: sum{t in T}((B - F) * X[t]) - sum{t in T} (C * A[t]) - sum{t in T} (G[t] * E[t]);

#RESTRICCIONES

s.t. demandaDiariaPorCliente{t in T}:sum{i in I}V[i,t] >= X[t];
s.t. cobertura90porciento{t in T}: X[t] >= 0.9 * sum{i in I} V[i,t];
s.t. variableEesUnidExtra {t in T}: E[t] = X[t]-W;
s.t. noSePagaFleteXmenorW{t in T}: X[t] <= W + M*A[t]; #Si ese dia se debe pagar el flete X es cualquier numero >0. No se paga el flete, X es menor que W
s.t. siSePagaFleteXmayorW{t in T}: X[t] >= W + 1 - (1-A[t])*M;   # si ese dia se debe pagar el flete, X es mayor que W. No s epaga flete, X es mayor que -M
s.t. naturalidadUnidExtra{t in T}: E[t] >= 0; 


#DATOS

data;


param W:= 4;

param C := 5;

param F := 14;

param B := 20;

param M := 9000;

param G :=
1 8
2 6
3 4
4 3
5 2
6 7
7 15;


param V:   1  2  3  4  5  6  7 :=
1   1  0  1  0  0  0  1
2   0  1  0  1  0  1  1
3   1  0  1  0  1  0  1
4   1  0  1  1  0  1  1
5   0  1  1  1  1  0  1
6   1  0  1  1  0  1  0
7   0  0  1  1  1  0  0
8   1  1  1  1  0  1  0
9   0  1  0  0  1  0  1
10  1  0  1  1  0  1  1
11  1  0  1  1  0  1  0
12  0  1  1  1  1  1  0
13  1  1  0  0  1  1  0
14  1  0  1  0  1  1  0
15  0  1  1  0  1  0  1;




end;

