#CONJUNTOS
set T := 1..7;   #DIAS
set I := 1..15;  #CLIENTES

#PARAMETROS
param W;     #limite diarios sin flete
param C;     #costo fijo flete
param G{T};  #costo unitario sobre W
param F;     #costo de compra diario
param B;     #precio de venta diario
param V{I,T};  #asistencia cliente i dia t
param M;     #penalizacion

#VARIABLES DE DECISION
var h{I,T} binary;   #1 si se le vende el diario al cliente i el dia t
var y{I,T} binary;   #1 si se le regala el diario al cliente i el dia t
var A{T} binary;     #1 si se debe pagar flete el dia t
var E{T} >= 0;       #cantidad de diarios que sobrepasan W el dia t
var X{T} >= 0 integer;  #cantidad total de diarios a llevar el dia t

#FUNCION OBJETIVO
maximize z: sum{t in T, i in I}(B*h[i,t]) - sum{t in T}(F * X[t]) - sum{t in T}(C * A[t]) - sum{t in T}(G[t] * E[t]);

#RESTRICCIONES
s.t. definicionX{t in T}: X[t] = sum{i in I}(h[i,t] + y[i,t]);
s.t. soloSiClienteVaVende{i in I, t in T}: h[i,t] <= V[i,t];
s.t. soloSiClienteVaRegala{i in I, t in T}: y[i,t] <= V[i,t];
s.t. noDobleEntrega{i in I, t in T}: h[i,t] + y[i,t] <= 1;
s.t. promo1{i in I, t in T: t >= 4}: y[i,t] <= h[i,t-1];
s.t. promo2{i in I, t in T: t >= 4}: y[i,t] <= h[i,t-2];
s.t. promo3{i in I, t in T: t >= 4}: y[i,t] <= h[i,t-3];
s.t. promo4{i in I, t in T: t >= 4}: y[i,t] >= h[i,t-1] + h[i,t-2] + h[i,t-3] - 2;


s.t. cobertura90porciento{t in T}: X[t] >= 0.9 * sum{i in I} V[i,t];
s.t. variableEesUnidExtra{t in T}: E[t] = X[t] - W;
s.t. noSePagaFleteXmenorW{t in T}: X[t] <= W + M*A[t];
s.t. siSePagaFleteXmayorW{t in T}: X[t] >= W + 1 - (1 - A[t])*M;
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