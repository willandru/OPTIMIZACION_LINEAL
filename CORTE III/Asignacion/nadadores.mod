#CONJUNTOS

set I:=1..6; # NADADORES  ={ 1: Mario, 2: Pedro 3:Juan , 4:Camilo, 5:Andres, 6:Gonzalo}
set J:=1..4; # ESTILOS j={1:Mariposa, 2:Espaldo, 3:Pecho, 4: Libre}


#PARAMETROS

param L; #longitud de la piscina
param N{J,I}; #Mejoras rendimientos de cada nadador I en cada estilo J

#VARIABELS DE DECISION

var X{J,I} binary; # Si se asigna o no el jugador I al estilo J


#fo

minimize Z: sum{i in I , j in J} X[j,i]*N[j,i];

#RESTRICCIONES


s.t. cadaNadadorUnaEstilo {i in I}: sum{j in J} X[j,i] =1;

s.t. siMarioPechoEntPedroLibre: X[3,1] <= X[4,2];
s.t. siJuanMariposaEntAndresNiGonzaloEspalda:   2*X[3,3] + X[2,5] + X[2,6] <= 2 ;
s.t. siCamiloEspaldayAndresPechoEntMarioLibre:  X[2,4] + X[3,5]  <= X[4,1] +1 ;




#DATOS


data;

param N:	1	2	3	4	5	6:=
1			29.2	26.4	29.6	29.6	30.2	28.7
2			43.4	33.1	42.2	39.9	40.5	41.1
3			33.3	28.5	38.9	30.6	34.1	33.3
4			37.7	32.9	33.8	39.4	33.2	34.3;


param L:= 50;

end;
