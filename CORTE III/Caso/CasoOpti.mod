#CONJUTOS
set R:=1..6; #Regiones 
set F:=1..5; # Familias de Arboles {1: Arecaceae, 2: Myrtaceae, 3: Meliaceae, 4: Dipterocarpaceae, 5: Fagaceae}
set A:=1..25; # Tipo de Arbol

set N:=1..5; #numero de restricciones condicionadas

#PARAMETROS

param AR{R}; #Area disponible para la region R en m^2
param AA{A}; #Area requerida para el arbol A en m^2/arbol
param AF{A,F}; # Si el arbol A pertenece a la familia F 
param RF{R,F}; #Familias F que son incompatibles en la region R
param FF{F,F}; #Familias F que son incompatibles  con otras familias F.
param C{A}; # Costo de plantar un arbol A en $USD/arbol 
param CO{A}; # Carbono secuestrado por los arboles A  Toneladas/(año*arbol)
param P; # Presupuesto  en $USD
param M; #numero muy grande

#VARIABLES

var X{F,R} binary; # 1 si se planta una familia F en la region R. 0 si no
var Y{A,R} >=0 integer; #Cantidad de arboles A plantados en  la region R
var B{N} binary; #si se cumple o no la restriccion N


#FUNCION OBJETIVO

maximize z: sum{a in A, r in R}Y[a,r]*CO[a];

#RESTRICCIONES

#lista de restricciones
s.t. cadaFamiliaMin10Porciento{f in F}:sum{a in A, r in R} Y[a, r] *  AF[a,f] * AA[a] >= sum{r in R} AR[r]*0.1; 
s.t. presupuestoTotal:sum{a in A, r in R} C[a] * Y[a,r] <= P; 

#3 de de las 5:
s.t. proporcionArboles7y12:sum{r in R} Y[12,r] * 20 >= sum{r in R} Y[7,r] * 30 - M * (1 - B[1]); 
s.t. areaMaxNoSembrada: sum{r in R} AR[r] - sum{a in A, r in R } Y[a,r] * AA[a] <=  200 - M*(1-B[2]); 
s.t. region1Minimo20CO2:sum {a in A} Y[a,1] * CO[a] >= 0.2* sum{a in A , r in R} Y[a,r] * CO[a] -M*(1-B[3]);
s.t. proprocionRegion2Minimo20: sum{a in A} Y[a,2] * AA[a]/ AR[2]>= 0.7 - M * (1 - B[4]);  
s.t. siEnRegion3y4Arbol5EntoncesNoEnRegion2noFamilia5 : X[5,3] +  X[5,4] + X[5,2] <= 2  +M*(1-B[5]);
s.t. sumadeBmayor3:sum{n in N} B[n]>=3;

#restricciones del contexto
s.t. compatibilidadFamiliaRegion{f in F, r in R}:X[f,r] <= 1 - RF[r,f]; 
s.t. siUsoRegionPlantoAhi{r in R, f in F}: sum{a in A} AF[a,f] * Y[a,r] >= X[f,r]; 
s.t. siNoUsoRegionNoPlantoAhi{r in R, f in F}: sum{a in A} AF[a,f] * Y[a,r] <= M * X[f,r]; 
s.t. compatibilidadEntreFamilias{r in R, f1 in F, f2 in F: f1 < f2}: X[f1,r] + X[f2,r] <= 2 - FF[f1,f2]; 
s.t. areaDisponiblePorRegion{r in R}: sum{a in A} AA[a]*Y[a,r] <=AR[r]; 

#DATOS

data;

param AR :=
1	16000
2	32000
3	27000
4	41000
5	18000
6	21000;

param P:= 500000; 

param AA :=
1  25
2  25
3  25
4  25
5  25
6  49
7  49
8  49
9  49
10 49
11 25
12 25
13 25
14 25
15 25
16 36
17 36
18 36
19 36
20 36
21 16
22 16
23 16
24 16
25 16;

param AF: 1 2 3 4 5 :=
1 1 0 0 0 0
2 1 0 0 0 0
3 1 0 0 0 0
4 1 0 0 0 0
5 1 0 0 0 0
6 0 1 0 0 0
7 0 1 0 0 0
8 0 1 0 0 0
9 0 1 0 0 0
10 0 1 0 0 0
11 0 0 1 0 0
12 0 0 1 0 0
13 0 0 1 0 0
14 0 0 1 0 0
15 0 0 1 0 0
16 0 0 0 1 0
17 0 0 0 1 0
18 0 0 0 1 0
19 0 0 0 1 0
20 0 0 0 1 0
21 0 0 0 0 1
22 0 0 0 0 1
23 0 0 0 0 1
24 0 0 0 0 1
25 0 0 0 0 1;


param RF:	1	2	3	4	5:=
1			0	0	0	1	1
2			1	0	1	0	0
3			0	1	0	0	0
4			0	0	1	0	0
5			0	1	0	0	1
6			1	0	0	1	0;


param FF:  1	2	3	4	5:=
1	0	0	0	0	0
2	0	0	1	1	0
3	0	1	0	0	0
4	0	1	0	0	1
5	0	0	0	1	0;




param C :=
1	61
2	70
3	50
4	100
5	80
6	45
7	40
8	80
9	52
10	41
11	200
12	73
13	66
14	182
15	201
16	159
17	157
18	185
19	182
20	187
21	254
22	251
23	256
24	203
25	206;

param CO :=
1	80
2	56
3	40
4	25
5	50
6	300
7	250
8	120
9	30
10	25
11	600
12	150
13	120
14	400
15	400
16	300
17	300
18	300
19	300
20	300
21	400
22	400
23	350
24	200
25	300;

param M:=999999;


end;

