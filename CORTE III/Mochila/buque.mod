#CONJUNTOS

set I:=1..5; # TIPO DE ARTICULO ={1, ... , 5}



#PARAMETROS


param W{I}; #Peso del articulo I
param V{I}; #Volumen del articulo I
param R{I}; #Precio de venta del articulo I
param Q{I}; #Cantidad disponible del articulo I
param P; #Peso maximo permisible de carga 
param U; #Volumen maximo permisible de carga 



#VARIABELS DE DECISION

var X{I} >=0 integer; #Unidades a cargar del articulo I

#FO

maximize Z: sum{i in I} X[i]*R[i];

#RESTRICCIONES

s.t. pesoMaximo:sum{i in I}X[i]*W[i]<= P;
s.t. volMaximo:sum{i in I}X[i]*V[i]<= U;
s.t. cargaMinima{i in I}:X[i] >= 0.2*Q[i];
s.t. cargaMaxima{i in I}:X[i] <= Q[i];


#DATOS


data;

param W:=
1	0.5
2	0.8
3	0.3
4	0.2
5	0.7;

param V:=
1	0.1
2	0.8
3	0.6
4	0.5
5	0.4;

param R:=
1	4
2	7
3	6
4	5
5	4;

param Q:=
1	50
2	40
3	70
4	80
5	100;

param P:=112;

param U:=109;

end;