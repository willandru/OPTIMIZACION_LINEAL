

#CONJUNTOS

set I:=1..12; # SOLICITUD ={1, .. , 12}



#PARAMETROS


param T{I}; #Tamaño de la casa  de la solicitud I
param V{I}; #Voluntarios requeridos para la solicitud I
param C{I}; #Calificacion de la solicitud I
param U; #Cantidad de voluntarios maximos
param H; #Area maxima a construir 



#VARIABELS DE DECISION

var X{I} binary; # Invertir o No en la Solicitud I

#FO

maximize Z: sum{i in I} X[i]*C[i];

#RESTRICCIONES

s.t. construccMaxima:sum{i in I}X[i]<=H;
s.t. voluntariMaximo:sum{i in I}X[i]*V[i]<=U;
s.t. si2EntoncesNo11: X[2] + X[11] <= 1 ;
s.t. si4o5Entonces7:  X[4] + X[5] <= X[7];


#DATOS


data;

param T:=
1	110
2	90
3	100
4	90
5	110
6	100
7	110
8	100
9	90
10	90
11	110
12	100;

param C:=
1	78
2	64
3	68
4	62
5	85
6	79
7	91
8	63
9	75
10	90
11	72
12	88;

param V:=
1	6
2	4
3	5
4	4
5	6
6	5
7	6
8	5
9	4
10	4
11	6
12	5;

param U:=30;

param H:= 730;

end;