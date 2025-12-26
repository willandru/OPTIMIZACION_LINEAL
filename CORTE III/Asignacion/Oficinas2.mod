#Ahora suponga que la empresa no tiene ninguna oficina en el momento, sino que debe decidir cuáles 6 oficinas arrendar de entre 10 posibles oficinas, y de las que arriende cómo asignarlas a cada uno de los 6 trabajadores. 

#En la siguiente tabla se presenta el valor del arriendo de un mes de cada oficina y los costos del transporte (ida y vuelta) entre las casas de los trabajadores a cada oficina. 

# Se sabe que los trabajadoren van a la oficina 20 días del mes. 
#Las condiciones de asignación de las oficinas de la parte I del problema se mantienen. 

#Formule un modelo para minimizar el costo de un mes.

#-----------------------------------------------------------------------------------------------------

#CONJUNTOS

set I:=1..6; # TRABAJADORES ={ 1: Juan, 2: Ana, 3:Pedro, 4:Camila, 5:Angela, 6:Sergio}
set J:=1..10; # OFICINAS={1..6}

#PARAMETROS

param CV{I,J}; #Costo de Viaje del trabajador I a la oficina J diario
param A{J}; # Arriendo mensual de cada oficina J
param D; #Numero de dias que trabaja en 1 mes
param O; #Numero de Oficinas que se van a arrendar

#VARIABLE DE DECISION

var X{I,J} binary ; # Trabajador I, es Asignado=1, o No es Asignado=0. a la oficina J
var Y{J} binary; # Se arreinda =1 o No se arrienda =0 la oficnia J

#FUNCION OBJETIVO

minimize Z: sum{i in I, j in J}X[i,j]*CV[i,j]*D + sum{j in J}Y[j]*A[j];

#RESTRICCIONES

s.t. cadaTrabajadorUnaOficina {i in I}:sum{j in J}X[i,j] =1;
s.t. cadaOficinaUnTrabajador {j in I}: sum{i in I}X[i,j] <=1;
s.t. cantOficinasArrendar : sum{j in J} Y[j]=O;
s.t. mismaCantOficinasArrendadas{j in J}: Y[j]=sum{i in I}X[i,j];
s.t. juanNoOficina3 : X[1,3]=0;
s.t. AnaEn3NoPedro5: X[2,3] + X[3,5]<=1;
s.t. AnaEn5NoPedro3: X[2,5] + X[3,3] <=1;
s.t. Juan1o4o5: X[1,1] + X[1,4] + X[1,5] <=1;
s.t. SiCamila1EntAna3: X[4,1] <= X[2,3];
s.t. SiSergio2yAna3EntAngela6: X[6,2] + X[2,3] <= X[5,6]+1;
s.t. SiJuanoSergio3EntCamila6: X[1,3] + X[6,3] <= 2*X[4,6];




data;

param CV:	1	2	3	4	5	6	7	8	9	10:=
1			50	50	9999	20	30	40	20	30	20	80
2			70	40	20	30	70	30	70	60	50	20
3			90	30	50	40	50	80	20	40	70	20
4			70	20	60	70	80	20	50	40	90	30
5			80	60	70	90	30	40	60	90	30	30
6			40	90	20	30	80	50	30	50	30	90;

param A:=
1	600
2	700
3	1000
4	1100
5	500
6	800
7	1200
8	800
9	900
10	700;

param D:=20;

param O:= 6;

end;