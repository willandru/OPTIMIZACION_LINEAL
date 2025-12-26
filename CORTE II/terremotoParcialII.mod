#Conjuntos


set I:={1..} #Centros de acopios regionales (Donde se ha almacendo
set J:={1..} #Centros logisticos intermedios {Coliseos, escuelas, instalaciones militares...}
set K:={1..} #Comunidades afectadas
set T:={1..2} #Tipos de kits de ayuda humanitaria


#Parametros

#Los costos  $ de transporte son unitarios y dependen del trayecto y del tipo de kit
param CA{I,J,T} # Costo $ de transportar un kit tipo T desde un centro acopio I a un centro logistico J
param CB{I,K,T} # Costo $ de transportar un kit tipo T desde un centro de acopio I a una comuncidad afectada K.
param CC{J,K,T} #Costo $ de transportar un kit tipo T desde un centro logistico J hasta una comunidad afectada K.

#por cada trayecto, existe una capacidad máxima de transporte por cada tipo de kit
param SA{I,J,T} # Capacidad maxima de de transporte de un kit tipo T desde un centro acopio I a un centro logistico J
param SB{I,K,T} # Capacidad maxima de de transporte de un kit tipo T desde un centro de acopio I a una comuncidad afectada K.
param SC{J,K,T} # Capacidad maxima de de transporte de un kit tipo T desde un centro logistico J hasta una comunidad afectada K.

param D{T,K} # número de kits T requeridos por la comunidad K



#PARAMETROS ADICCIONALES POSIBLES

param VI{I,T}; #Cantidad maxima almacenada del kit T en el centro de acopio I
param Qo{I,T}; #Cantidad inicial disponible del kit T en el centro de acopio I

param VJ{J,T}; #Cantidad maxima almacenada del kit T en el centro logistico intermedio J
param Io{I,T}; #Cantidad inicial disponible del kit T en el centro de acopio J



#Variables de descicion
var X{I,J,T} >=0;  #Cantidad de kits tipo T envaidos del centro de acopio I a el centro logistico J
var Y{J,K,T} >=0;  #Cantidad de kits tipo T enviados del centro logistico J a la comunidad K
var W{I,K,T} >=0;  #Cantidad de kits tipo T enviados del centro de acopio I a la comunidad K


####
# 1) las donaciones no son suficientes para cubrir la demanda, 
# 2) los caminos dañados solo permiten tránsito en ciertos tramos
# 3) la disponibilidad de vehículos es limitada
# 4) los centros intermedios tienen capacidad restringida para recibir y almacenar productos antes de su redistribución
#Finalmente, algunos destinos solo pueden ser alcanzados a través de rutas indirectas, utilizando estos centros intermedios como puntos de conexión.

#----VARIABLES DE DECISION----
var U{J,T} >= 0;      # cantidad almacenada en centro logistico j al final (opcional)
var Z{T,K} >= 0;      # déficit: d_{t,k} - entregado (kits no satisfechos)



# --------- FUNCIÓN OBJETIVO ----------
minimize Z:
    sum {i in I, j in J, t in T} CA[i,j,t] * X[i,j,t]
  + sum {i in I, k in K, t in T} CB[i,k,t] * W[i,k,t]
  + sum {j in J, k in K, t in T} CC[j,k,t] * Y[j,k,t]
  + PENALTY * sum {t in T, k in K} Z[t,k];
  
  
  
#RESTRICCIONES

# --------- RESTRICCIONES ----------

# 1) Capacidades por arco (si el arco no existe, pone SA/SB/SC = 0 en los datos)
s.t. CAP_AX{i in I, j in J, t in T}:
    X[i,j,t] <= SA[i,j,t];

s.t. CAP_AK{i in I, k in K, t in T}:
    W[i,k,t] <= SB[i,k,t];

s.t. CAP_JK{j in J, k in K, t in T}:
    Y[j,k,t] <= SC[j,k,t];

# 2) Disponibilidad en centros de acopio: no enviar más que lo disponible
s.t. ACOPIO_SUPPLY{i in I, t in T}:
    sum {j in J} X[i,j,t] + sum {k in K} W[i,k,t] <= Qo[i,t];

# 3) Balance en centros logísticos: lo que sale no puede exceder lo que entra + espacio inicial
# (si no hay inventario inicial en J, entonces solo entra = sale + almacenado)
s.t. LOG_BUDGET{j in J, t in T}:
    sum {k in K} Y[j,k,t] + U[j,t] = sum {i in I} X[i,j,t];

# 4) Capacidad de almacenamiento en centros logísticos
s.t. LOG_CAP{j in J, t in T}:
    U[j,t] <= VJ[j,t];

# 5) Demanda: entregado + déficit = demanda
s.t. DEMAND_SATISF{t in T, k in K}:
    sum {i in I} W[i,k,t] + sum {j in J} Y[j,k,t] + Z[t,k] = D[t,k];

# 6) (Opcional) límites físicas de almacenamiento en acopio
s.t. ACAPAC{i in I, t in T}:
    sum {j in J} X[i,j,t] + sum {k in K} W[i,k,t] <= VI[i,t];

#7)  NO ALMACENAMIENTO EN J ; todo lo que entra a J debe salir: 
s.t. NO_STORAGE_AT_J{j in J, t in T}:
    sum{i in I} X[i,j,t] = sum{k in K} Y[j,k,t];

#8) 

var U{J,T} >= 0;  # inventario final (sobrante) en j para tipo t

s.t. BALANCE_AT_J{j in J, t in T}:
    Io[j,t] + sum{i in I} X[i,j,t] = sum{k in K} Y[j,k,t] + U[j,t];







