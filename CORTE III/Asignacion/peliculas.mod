

#CONJUNTOS


set I:=1..7; # CIUDADES j={1:Origen, 2:A, 3:B, 4:C, 5:D, 6:E, 7:F}
set J:=1..10; # PELICULAS ={1..10}


#PARAMETROS


param O; #Costo por milla de conduccion 
param M{I}; #Millas de viaje ida y vuelta a la ciudad I
param C{I,J}; #Costo por pelicula 


#VARIABELS DE DECISION

var X{I,J} binary; # Si visita la ciudad I para ver la pelicula J
var Y{I} binary; #Si visita la ciudad J

#FO

minimize Z: sum{i in I , j in J} X[i,j]*C[i,j] +  sum{i in I} Y[i]*M[i]*O;

#RESTRICCIONES

s.t. cadaPeliculaUnaVez{j in J}:sum{i in I}X[i,j] =1;
s.t. vePeliculaSiVisitaLaCiudad{i in I, j in J}:X[i,j] <= Y[i];


#DATOS


data;

param C:	1	2	3	4	5	6	7	8	9	10:=
1			7.95	 1000	7.95	 1000	 1000	 1000 	 1000 	 1000 	 1000 	 1000
2			5.50	 1000	 1000	 1000	 1000	5.50 	 1000 	5.50 	 1000 	 1000
3			 1000	5.00	 1000	 1000	5.00	 1000 	5.00 	 1000 	 1000 	 1000
4			7.00	 1000	 1000	 1000	 1000	 1000 	 1000 	7.00	7.00 	 1000
5			 1000	4.95	 1000	4.95	 1000	 1000 	4.95 	 1000	 1000 	 1000
6			5.25	 1000	5.25	 1000	5.25	 1000 	 1000 	 1000 	 1000 	5.25
7			 1000	 1000	 1000	6.75	6.75	6.75 	 1000 	 1000 	6.75 	 100;

param M:=
1	0
2	25
3	30
4	28
5	40
6	35
7	32;

param O:= 0.75;

end;