#Conjuntos

set I:=1..6; # Fondos de pension
set J:=1..3; # Categoria de riesgo 

#Parametros

param P{I}; # Precio de los fondos I
param T{I}; #Tasa esperada de retorno del fondo I.
param Qmin{J}; #Cantidad minima invertida por riesgo J.
param Qmax{J}; #Cantidad maxima invertida por riesgo J.

#Variables de Decision

#FuncionObjetivo

#Restricciones


#Datos

data;

param P:=
1	45
2	76
3	110
4	17
5	23
6	22;

param T:=
1	0.3
2	0.2
3	0.15
4	0.12
5	0.1
6	0.07;

param Qmin:=
1	0.5
2	0.2
3	0.05;

param Qmax:=
1	0.75
2	0.3
3	1;

end;
