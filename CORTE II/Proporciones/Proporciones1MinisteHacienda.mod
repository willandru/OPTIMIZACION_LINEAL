#Conjntos

set I:=1..4; #Programa
set J:=1..4; # Departamentos
set K:=1..3; #Temas

# Parametros
param Q{I}; # Cupos maximos del programa I
param C{I}; #Costo por participante al programa I
param H{I,K}; #Intensidad Horaria del tema K en el programa I
param E{J}; #Numero de empleados postulados por cada departamento J
param R{J,K}; #Demanda minima de horas que deben tomar los empleados el tema K en el programa J.


#Variables de descicion
var X{I,J}>=0 integer; #Cantidad de empleados del departamento J que van a tomar el programa I


#Funcion Objetivo
minimize Z: sum{i in I, j in J}X[i,j]*C[i];

#Restricciones 

s.t. cuposLimiteProgramas{i in I}:sum{j in J}X[i,j] <= Q[i]; 
s.t. demandaMinimaDepartamentoporTema{j in J, k in K}:sum{i in I}X[i,j]*H[i,k] >= R[j,k];
s.t. empleadosDisponiblesporDepartamento{j in J}:sum{i in I}X[i,j] <= E[j];
#Asi mismo se debe garantizar que todos los departamentos tengan el mismo porcentaje de satisfaccion de la demanda (medida en empleados inscritos) ya que se sabe que no todos los empleados disponibles pueden tomar cursos. 
s.t. proporcionEmpleadosInscritosporDepartamento{j in J,h in J: h!=j}:sum{i in I}X[i,j]/E[j]=sum{i in I}X[i,h]/E[h];


data;

param Q:=
1	12
2	10
3	20
4	18;

param C:=
1	300
2	400
3	350
4	200;

param H:	1	2	3:=
1			20	35	45
2			50	20	30
3			30	40	30
4			15	30	55;

param E:=
1	50
2	50
3	50
4	50;

param R:	1	2	3:=
1			80  	150 	100
2			60  	90  	150
3			150 	70  	130
4			120 	160 	110;

end;