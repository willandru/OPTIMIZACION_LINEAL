set I := 1..8;   # Transmisores
set J := 1..16;  # Localidades

param M;         # Presupuesto máximo
param C{I};      # Costo de cada transmisor
param T{I,J};    # 1 si el transmisor i cubre la localidad j, 0 si no
param P{J};      # Población de cada localidad


var X{I} binary;          # 1 si se construye el transmisor i
var Y{J} binary;          # 1 si la localidad j está cubierta por al menos un transmisor


param alpha := 1000;  # peso de la población cubierta
param beta := 1;      # penalización por transmisores construidos

maximize objetivo:
    sum{j in J} alpha*P[j]*Y[j] - sum{i in I} beta*X[i];


s.t. presupuestoMaximo:
    sum{i in I} X[i]*C[i] <= M;
s.t. cobertura{j in J}:
    sum{i in I} T[i,j]*X[i] >= Y[j];


data;

param M := 20;

param C :=
1 3.6
2 2.3
3 4.1
4 3.15
5 2.8
6 2.65
7 3.1
8 4;

param P :=
1 10
2 15
3 28
4 30
5 40
6 30
7 20
8 15
9 60
10 12
11 25
12 32
13 12
14 15
15 45
16 35;

param T:
   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 :=
1  1  1  0  0  0  0  0  0  0  0  0  0  1  0  0  1
2  0  1  1  0  1  0  0  0  0  0  0  0  0  0  1  0
3  1  0  0  0  0  0  1  0  1  1  0  0  0  0  0  0
4  0  0  0  1  0  1  0  1  1  0  0  0  0  0  0  1
5  0  0  0  0  0  1  1  0  1  0  1  0  0  0  0  0
6  0  0  0  0  1  0  1  0  0  1  0  1  0  1  0  0
7  0  0  0  0  0  0  0  0  0  0  0  1  1  1  1  0
8  0  0 0  1  0  1  0  0  0  1  0  1  0  0  0  1;

end;

