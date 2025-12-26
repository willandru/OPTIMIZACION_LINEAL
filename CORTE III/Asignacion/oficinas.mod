# PROBLEMA 1. ASIGNACIÓN OFICINAS A TRABAJADORES


#Una empresa necesita asignar 6 oficinas ubicadas en diferentes puntos de la ciudad a 6 trabajadores (Juan, Ana, Pedro, Camila, Ángela y Sergio), 


#La empresa debe pagar los transportes desde los hogares de los trabajadores hasta la oficinas (ida y vuelta).
#El costo del viaje de ida y vuelta [$] entre el hogar de cada trabajador y cada oficina se presenta en la tabla. 

#RESTRICCIONES

#donde cada oficina debe ser asignada a un solo trabajador y cada trabajador debe ser asignado a una sola oficina. 
#Juan no puede ser asignado a la oficina 3 debido a que tomaría mucho tiempo viajar desde su casa hasta dicha oficina
#Dado que las oficinas 3 y 5 pertenecen a la misma zona y Ana y Pedro no pueden trabajar cerca, si Ana es asignada a la oficina 3 entonces Pedro no puede ser asignado a la oficina 5 ó si Ana es asignada a la oficina 5 Pedro no puede ser asignado a la oficina 3.
# Juan quiere ser asignado a una de las oficinas 1, 4 o 6.
# Si Camila es asignada a la oficina 1 entonces Ana debe ser asignada a la oficina 3
# Si Sergio es asignado a la oficina 2 y Ana es asignada a la oficina 3 entonces Ángela debe ser asignada a la oficina 6
# Si Juan o Sergio son asignados a la oficina 3 entonces Camila debe ser asignada a la oficina 6


#CONJNUNTOS

set I:=1..6; # TRABAJADORES ={ 1: Juan, 2: Ana, 3:Pedro, 4:Camila, 5:Angela, 6:Sergio}
set J:=1..6; # OFICINAS={1..6}

#PARAMETROS

param CV{I,J}; #Costo de Viaje del trabajador I a la oficina J

#VARIABLE DE DECISION

var X{I,J} binary ; # Trabajador I, es Asignado=1, o No es Asignado=0. a la oficina J

#FUNCION OBJETIVO

minimize Z: sum{i in I, j in J}X[i,j]*CV[i,j];

#RESTRICCIONES

s.t. cadaTrabajadorUnaOficina {i in I}:sum{j in J}X[i,j] =1;
s.t. cadaOficinaUnTrabajador {j in I}: sum{i in I}X[i,j] =1;
s.t. juanNoOficina3 : X[1,3]=0;
s.t. AnaEn3NoPedro5: X[2,3] + X[3,5]<=1;
s.t. AnaEn5NoPedro3: X[2,5] + X[3,3] <=1;
s.t. Juan1o4o5: X[1,1] + X[1,4] + X[1,5] <=1;
s.t. SiCamila1EntAna3: X[4,1] <= X[2,3];
s.t. SiSergio2yAna3EntAngela6: X[6,2] + X[2,3] <= X[5,6]+1;
s.t. SiJuanoSergio3EntCamila6: X[1,3] + X[6,3] <= 2*X[4,6];




data;

param CV:	1	2	3	4	5	6:=
1			50	50	9999	20	30	40
2			70	40	20	30	70	30
3			90	30	50	40	50	80
4			70	20	60	70	80	20
5			80	60	70	90	30	40
6			40	90	20	30	80	50;


end;