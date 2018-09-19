;;; Hechos estaticos;
(deffacts Habitaciones
  (Habitacion Recepcion)    ;;;;  Receptión es una habitación
  (Habitacion Pasillo)
  (Habitacion Oficina1)
  (Habitacion Oficina2)
  (Habitacion Oficina3)
  (Habitacion Oficina4)
  (Habitacion Oficina5)
  (Habitacion OficinaDoble)
  (Habitacion Gerencia)
  (Habitacion Papeleria)
  (Habitacion Aseos)
  (Habitacion AseoHombres)
  (Habitacion AseoMujeres)
)
(deffacts Puertas
  (Puerta Recepcion Pasillo)    ;;;; Hay una puerta que comunica Recepción con Pasillo
  (Puerta Pasillo Oficina1)
  (Puerta Pasillo Oficina2)
  (Puerta Pasillo Oficina3)
  (Puerta Pasillo Oficina4)
  (Puerta Pasillo Oficina5)
  (Puerta Pasillo Gerencia)
  (Puerta Pasillo OficinaDoble)
  (Puerta Pasillo Papeleria)
)
  (deffacts Empleados
    (Empleado G1 Oficina1)          ;;;;; El empleado G1 atiende en la Oficina 1, iremos modificando esto a medida que se mueva de sala
    (Empleado G2 Oficina2)
    (Empleado G3 Oficina3)
    (Empleado G4 Oficina4)
    (Empleado G5 Oficina5)
    (Empleado E1 OficinaDoble-1)
    (Empleado E2 OficinaDoble-2)
    (Empleado Recepcionista Recepcion)
    (Empleado Director Gerencia)
  )
   (deffacts Codificacion
    (Code TG "Tramites Generales")
    (Code TE "Tramites Especiales")
   )
  (deffacts Tareas
    (Tarea G1 TG)                   ;;;;; El empleado G1 atiende Trámites Generales
    (Tarea G2 TG)
    (Tarea G3 TG)
    (Tarea G4 TG)
    (Tarea G5 TG)
    (Tarea E1 TE)                   ;;;;; El empleado E1 atiende Trámites Especiales
    (Tarea E2 TE)
  )

  (deftemplate estadoEmpleado ; Estadísticas
    (slot empleado (type SYMBOL) (default ?NONE))
    (slot estado (type SYMBOL) (default ?NONE))
    (slot numeroTramites)
    (slot tiempoTotal)
    (slot salidas)
  )

  (deffacts Inicializacion
    (Personas 0)                    ;;; Inicialmente hay 0 personas en las oficinas
    (Usuarios TG 0)                 ;;; Inicialmente hay 0 Usuarios de trámites generales
    (UltimoUsuarioAtendido TG 0)    ;;; Inicialmente se han atendido 0 usuarios de tramites generales
    (Usuarios TE 0)
    (UltimoUsuarioAtendido TE 0)
    (Empleados 0)                   ;;; Inicialmente hay 0 empleados en las oficinas
    (Empleados TG 0) ; Añadido para el ejercicio 2, esto es para controlar el número de empleados y poder avisar en caso de haber menos de los que debería
    (Empleados TE 0) ; Añadido para el ejercicio 2, esto es para controlar el número de empleados y poder avisar en caso de haber menos de los que debería
    (Ficho G1 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Ficho G2 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Ficho G3 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Ficho G4 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Ficho G5 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Ficho E1 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Ficho E2 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Ficho Director 0) ; Añadido para el ejercicio 3, con esto sabemos si un empleado ha fichado 1 o por el contrario no 0
    (Esta G1 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (Esta G2 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (Esta G3 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (Esta G4 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (Esta G5 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (Esta E1 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (Esta E2 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (Esta Director 0) ; Añadido para el ejercicio 3, este hecho nos vale para saber que el empleado ya llego (ficho) pero claro este puede salir a desayunar en cuyo caso sigo como fichado por lo que necesitamos saber que ha salido pero que el ya ficho
    (estadoEmpleado (empleado G1) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (estadoEmpleado (empleado G2) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (estadoEmpleado (empleado G3) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (estadoEmpleado (empleado G4) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (estadoEmpleado (empleado G5) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (estadoEmpleado (empleado E1) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (estadoEmpleado (empleado E2) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (estadoEmpleado (empleado Director) (estado NOLLEGO) (numeroTramites 0) (tiempoTotal 0) (salidas 0)) ; Añadido para el ejercicio 3, para el informe que se nos pide y para saber el estado del empleado el cual podemos preguntar gracias a la regla que se activa con (pregunta EMPLEADO), también sabremos el número de veces que salío (salidas) para en caso de ser más de una dar un aviso
    (tiempoMensaje 4) ; Tiempo para volver a sacar un mensaje por pantalla
    (Ejecutar)
  )

  (deffacts Luces
    (Luz Oficina1 OFF) ; Controlar las luces, es muy sencillo de entender, no es necesaria la expliación
    (Luz Oficina2 OFF)
    (Luz Oficina3 OFF)
    (Luz Oficina4 OFF)
    (Luz Oficina5 OFF)
    (Luz OficinaDoble OFF)
    (Luz Gerencia OFF)
    (Luz Papeleria OFF)
    (Luz Recepcion OFF)
    (Luz Pasillo OFF)
    (Luz Aseos OFF)
    (Luz AseoHombres OFF)
    (Luz AseoMujeres OFF)
  )

  (deffacts cantidadPersonas
    (cantidad Oficina1 0 2) ; Cantidad de personas en una oficina, el 0 es ninguna en principio y el número de la derecha es el máximo permitido
    (cantidad Oficina2 0 2)
    (cantidad Oficina3 0 2)
    (cantidad Oficina4 0 2)
    (cantidad Oficina5 0 2)
    (cantidad OficinaDoble 0 4)
  )

  ;(deffacts Constantes
  ;(ComienzoJornada 8)
  ;(FinalJornada 14)
  ;(ComienzoAtencion 9)
  ;(MinimoEmpleadosActivos TG 3)
  ;(MinimoEmpleadosActivos TE 1)
  ;(MaximoEsperaParaSerAtendido TG 30)
  ;(MaximoEsperaParaSerAtendido TE 20)
  ;(MaximoTiempoGestion TG 10)
  ;(TiempoMedioGestion TG 5)
  ;(MaximoTiempoGestion TE 15)
  ;(TiempoMedioGestion TE 8)
  ;(TiempoMaximoRetraso 15)
  ;(TiempoMaximoDescanso 5)
  ;(MinimoTramitesPorDia TG 20)
  ;(MinimoTramitesPorDia TE 15)
  ;)

  (defrule cargarconstantes
    (declare (salience 10000)) ; Salience es la prioridad
    =>
    (load-facts Constantes.txt)
  )


  ;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;; PASO1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;respuestas ante los hechos (Solicitud ?tipotramite) y (Disponible ?empl);;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  ;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;; 1A ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defrule EncolarUsuario                       ; Aquí recibimos una solicitud de un nuevo usuario y lo metemos en la cola, también llevaremos el número de usuarios total que pasan por el establecimiento,
    ?g <- (Solicitud ?tipotramite)              ; por otro lado crearemos un hecho sobre la hora en la que el usuario empezo a esperar a fin de poder saber cuanto lleva esperando
    ?f <- (Usuarios ?tipotramite ?n)
    (hora_actual ?h) ; Añadido Ejercicio 2
    (minutos_actual ?m) ; Añadido Ejercicio 2
    (NumeroSegundos ?s) ; Añadido Ejercicio 2
    =>
    (assert (Usuario ?tipotramite (+ ?n 1))
            (Usuarios ?tipotramite (+ ?n 1))
    )
    (assert (Usuario ?tipotramite (+ ?n 1) (totalminutos ?h ?m))) ; Añadido Ejercicio 2
    (assert (horaAntigua (totalminutos ?h ?m))) ; Añadido Ejercicio 2
    (printout t "Su turno es " ?tipotramite " " (+ ?n 1)  crlf)
    (retract ?f ?g)
  )

  ;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;; 1B ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defrule RegistrarCaso                          ; Una vez el empleado resuelve el problema del usuario, sabremos cuanto tiempo le ha llevado a fin de poder sacar un informe posteriormente,
    (Disponible ?empl)                            ; también tendremos otro registro para posteriormente saber el tiempo total y medio de cada tipo de trámite así como el número de este
    ?f <- (Asignado ?empl ?tipotramite ?n)
    ?x <- (AsignadoT ?empl ?tipotramite ?n ?min)
    (hora_actual ?h) ; Añadido Ejercicio 2
    (minutos_actual ?m) ; Añadido Ejercicio 2
    ?k <- (estadoEmpleado (empleado ?empl) (estado ?e) (numeroTramites ?nt) (tiempoTotal ?tt) (salidas ?sal)) ; Ejercicio 3
    =>
    (assert (Tramitado ?empl ?tipotramite ?n))
    (assert (AsignadoMedia ?tipotramite ?n (- (totalminutos ?h ?m) ?min)))
    (assert (estadoEmpleado (empleado ?empl) (estado DISPONIBLE) (numeroTramites (+ ?nt 1)) (tiempoTotal (+ ?tt (- (totalminutos ?h ?m) ?min))) (salidas (+ ?sal 1))))
    (retract ?f ?x ?k)
  )

  (defrule AsignarEmpleado                                  ; Aquí asignamos a un empleado un usuario de los que esperan, aumentaremos contadores, anotaremos a donde tiene que ir el usuario
    ?g <- (Disponible ?empl)                                ; a fin de poder saber si se equivoca o no de oficina, colocaremos el estado del empleado en atendiendo y anotaremos la hora a la
    (Tarea ?empl ?tipotramite)                              ; que se empezo a atender a fin de poder sacar estadísticas a posteriori (horaAntigua1)
    (Empleado ?empl ?ofic)
    ?f <- (UltimoUsuarioAtendido ?tipotramite ?atendidos)
    (Usuarios ?tipotramite ?total)
    (test (< ?atendidos ?total))
    (hora_actual ?h) ; Añadido Ejercicio 2
    (minutos_actual ?m) ; Añadido Ejercicio 2
    ?k <- (estadoEmpleado (empleado ?empl) (estado ?e) (numeroTramites ?nt) (tiempoTotal ?tt) (salidas ?sal)) ; Ejercicio 3
    =>
    (bind ?a (+ ?atendidos 1))
    (assert (AsignadoT ?empl ?tipotramite ?a (totalminutos ?h ?m))) ; Añadido Ejercicio 2
    (assert (horaAntigua1 (totalminutos ?h ?m))) ; Añadido Ejercicio 2
    (assert (Asignado ?empl ?tipotramite ?a))
    (assert (UltimoUsuarioAtendido ?tipotramite ?a))
    (assert (UsuarioOficina ?tipotramite ?total ?ofic))
    (printout t "Usuario " ?tipotramite ?a ", por favor pase a " ?ofic crlf)
    (modify ?k (estado ATENDIENDO)) ; Ejercicio 3
    (retract ?f ?g)
  )

  ;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;; 1C ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defrule NoposibleEncolarUsuario                    ; Aquí veremos si podemos encolar al usuario o por el contrario no y tendrá que irse, veremos si se cumplen todos los requisitos y en
    (declare (salience 20))                           ; en caso de que no le informaremos de que no le podemos atender por falta de tiempo.
    ?g <- (Solicitud ?tipotramite)
    (Usuarios ?tipotramite ?n)
    (UltimoUsuarioAtendido ?tipotramite ?atendidos)
    (TiempoMedioGestion ?tipotramite ?m)
    (FinalJornada ?h)
    (test (> (* (- ?n ?atendidos) ?m) (mrest ?h)))
    (Code  ?tipotramite ?texto)
    =>
    (printout t "Lo siento pero por hoy no podremos atender mas " ?texto crlf)
    (bind ?a (- ?n ?atendidos))
    (printout t "Hay ya  " ?a " personas esperando y se cierra a las " ?h "h. No nos dara tiempo a atenderle." crlf)
    (retract ?g)
  )


;;;;;; Ejercicio 2

  (defrule marcaHoraLlega                     ; Aquí creamos un hecho auxiliar que es como el llega pero añadiendo un 0 simplemente porque el sistema elimina el hecho llega y nosotros
    (llega ?empl ?h ?m ?s)                    ; necesitamos el hecho para posteriormente saber el estado de los empleados, sin esta regla nuestro sistema no comenzaría a ejecutarse pues se
    (not (exists (llega ?empl ?h ?m ?s ?n)))  ; produciría un bucle infinito
    =>
    (assert (llega ?empl ?h ?m ?s 0))
  )

  (defrule marcaHoraSeva                      ; Como la de arriba pero para el seva
    (seva ?empl ?h ?m ?s)
    (not (exists (seva ?empl ?h ?m ?s ?n)))
    =>
    (assert (seva ?empl ?h ?m ?s 0))
  )

  (defrule sevaEmpleados   ; Ejercicio 2 a      ; Esta regla realmente la podríamos dejar como una sola en el ejercicio 3 pues ahí controlamos cuando un empleado se va o llega pero puesto
    ?x <- (seva ?empl ?h ?m ?s 0)               ; que son ejercicios diferentes lo dejaremos como dos reglas pero se podrían combinar en una, en la sale del ejercicio 3
    (Tarea ?empl ?tipotramite)
    ?e <- (Empleados ?tipotramite ?n)
    =>
    (assert (Empleados ?tipotramite (- ?n 1)))
    (assert (seva ?empl ?h ?m ?s 1))
    (retract ?e ?x)
  )

  (defrule llegaEmpleado   ; Ejercicio 2 a      ; Esta regla realmente la podríamos dejar como una sola en el ejercicio 3 pues ahí controlamos cuando un empleado se va o llega pero puesto
    ?x <- (llega ?empl ?h ?m ?s 0)              ; que son ejercicios diferentes lo dejaremos como dos reglas pero se podrían combinar en una, en la llegoMarca y llegoSinMarca del ejercicio 3
    (Tarea ?empl ?tipotramite)
    ?e <- (Empleados ?tipotramite ?n)
    =>
    (assert (Empleados ?tipotramite (+ ?n 1))) ; Añadido para el ejercicio 2
    (assert (llega ?empl ?h ?m ?s 1))
    (retract ?e ?x)
  )

  (defrule infraEmpleadosTG   ; Ejercicio 2 a   ; Nos avisade de deficit de empleados de TG
    (MinimoEmpleadosActivos TG ?n)
    (Empleados TG ?e)
    (test (> ?n ?e))
    (hora_actual ?h)
    (minutos_actual ?min)
    ?x <- (horaAntigua ?o)                      ; De informar de pocos empleados lo haríamos cuando entre en cola un usario y este hecho se crea justo ahí, con esto conseguimos que en caso de haber menos de 3 se informe al nuevo usuario si han pasado más de 4 minutos del último
    (tiempoMensaje ?uu)
    (test (> (totalminutos ?h ?min) (+ ?o ?uu)))
    =>
    (printout t "Le informamos de que hay menos de " ?n " empleados atendiendo tramites generales" crlf)
  )

  (defrule infraEmpleadosTE   ; Ejercicio 2 a   ; Nos avisade de deficit de empleados de TG
    (MinimoEmpleadosActivos TE ?n)
    (Empleados TE ?e)
    (test (> ?n ?e))
    (hora_actual ?h)
    (minutos_actual ?min)
    ?x <- (horaAntigua ?o)                      ; De informar de pocos empleados lo haríamos cuando entre en cola un usario y este hecho se crea justo ahí, con esto conseguimos que en caso de haber menos de 1 se informe al nuevo usuario si han pasado más de 4 minutos del último
    (tiempoMensaje ?uu)
    (test (> (totalminutos ?h ?min) (+ ?o ?uu)))
    =>
    (printout t "Le informamos de que hay menos de " ?n " empleados atendiendo tramites específicos" crlf)
  )

  (defrule maxUsuarioEsperaTG   ; Ejercicio 2 a     ; Nos avisa de cuanto un usuario lleva más de 30 minutos esperando, el aviso aparece cada dos minutos (según nuestro criterio)
    (MaximoEsperaParaSerAtendido TG ?n)
    (Usuario TG ?m ?t)
    (hora_actual ?h)
    (minutos_actual ?min)
    ?x <- (horaAntigua ?o)
    (tiempoMensaje ?uu)
    (test (> (totalminutos ?h ?min) (+ ?o ?uu)))
    =>
    (assert (horaAntigua (totalminutos ?h ?min)))
    (retract ?x)
    (if (> (- (totalminutos ?h ?min) ?t) ?n) then
      (printout t "Sentimos la espera usuario TG" ?m " lleva más de " ?n " minutos esperando" crlf)
    )
  )

  (defrule maxUsuarioEsperaTE   ; Ejercicio 2 a     ; Nos avisa de cuanto un usuario lleva más de 10 minutos esperando, el aviso aparece cada dos minutos (según nuestro criterio)
    (MaximoEsperaParaSerAtendido TE ?n)
    (Usuario TE ?m ?t)
    (hora_actual ?h)
    (minutos_actual ?min)
    ?x <- (horaAntigua ?o)
    (tiempoMensaje ?uu)
    (test (> (totalminutos ?h ?min) (+ ?o ?uu)))
    =>
    (assert (horaAntigua (totalminutos ?h ?min)))
    (retract ?x)
    (if (> (- (totalminutos ?h ?min) ?t) ?n) then
      (printout t "Sentimos la espera usuario TE" ?m " lleva más de " ?n " minutos esperando" crlf)
    )
  )

  (defrule maxUsuarioAtendidoTG   ; Ejercicio 2 a     ; Nos avisa de cuanto un usuario lleva más de 10 minutos siendo atendido, el aviso aparece cada dos minutos (según nuestro criterio)
    (MaximoTiempoGestion TG ?n)
    (AsignadoT ?empl TG ?a ?t)
    (hora_actual ?h)
    (minutos_actual ?min)
    ?x <- (horaAntigua1 ?o)
    (tiempoMensaje ?uu)
    (test (> (totalminutos ?h ?min) (+ ?o ?uu)))
    =>
    (assert (horaAntigua1 (totalminutos ?h ?min)))
    (retract ?x)
    (if (> (- (totalminutos ?h ?min) ?t) ?n) then
      (printout t "El usuario TG" ?a " lleva más de " ?n " minutos siendo atendido" crlf)
    )
  )

  (defrule maxUsuarioAtendidoTE   ; Ejercicio 2 a     ; Nos avisa de cuanto un usuario lleva más de 5 minutos siendo atendido, el aviso aparece cada dos minutos (según nuestro criterio)
    (MaximoTiempoGestion TE ?n)
    (AsignadoT ?empl TE ?a ?t)
    (hora_actual ?h)
    (minutos_actual ?min)
    ?x <- (horaAntigua1 ?o)
    (tiempoMensaje ?uu)
    (test (> (totalminutos ?h ?min) (+ ?o ?uu)))
    =>
    (assert (horaAntigua1 (totalminutos ?h ?min)))
    (retract ?x)
    (if (> (- (totalminutos ?h ?min) ?t) ?n) then
      (printout t "El usuario TE" ?a " lleva más de " ?n " minutos siendo atendido" crlf)
    )
  )

  (defrule generaInformeEj23              ; Una vez hemos finalizado la ejecución de simulación se nos generará un informe sobre el desempeño de los empleados así como datos generales de la jornada
    (not (exists (ciclo ?n)))
    (UltimoUsuarioAtendido TG ?atendidos)
    (UltimoUsuarioAtendido TE ?atendidos1)
    (not (exists (MediaTG ?a ?b) (MediaTE ?c ?d) (DesviacionTG ?e ?f) (DesviacionTE ?g ?h) (entro)))
    =>
    (assert (MediaTG 0 0))
    (assert (MediaTE 0 0))
    (assert (DesviacionTG 0 0))
    (assert (DesviacionTE 0 0))
    (assert (Desempenio G1) (Desempenio G2) (Desempenio G3) (Desempenio G4) (Desempenio G5) (Desempenio E1) (Desempenio E2))
    (printout t "El numero de tramites de TG atendidos es " ?atendidos crlf)
    (printout t "El numero de tramites de TE atendidos es " ?atendidos1 crlf)
  )

  (defrule calculaMediaTG                   ; Regla recursiva que se estará llamando hasta que en AsignadoMedia tengamos en el 3 contador un 0 lo cual quiere decir que hemos revisado todas las atenciones que hemos hecho a lo largo de la jornada
    ?x <- (MediaTG ?contador ?sumatoria)
    ?y <- (AsignadoMedia TG ?m ?t)
    =>
    (assert (MediaTG (+ ?contador 1) (+ ?sumatoria ?t)))
    (if (eq ?m 0) then
      (assert (ImprMediaTG))
    )
    (if (neq ?m 0) then
      (assert (AsignadoMedia TG (- ?m 1) ?t))
    )
    (retract ?x ?y)
  )

  (defrule ImprimirMediaTG                ; Tan solo nos vale para imprimir
    ?x <- (ImprMediaTG)
    ?y <- (MediaTG ?contador ?sumatoria)
    =>
    (assert (MediaTGD ?contador ?sumatoria))
    (printout t "La media de tiempo en los tramites generales es de " (/ ?sumatoria ?contador) crlf)
    (retract ?x ?y)
  )

  (defrule calculaMediaTE                   ; Regla recursiva que se estará llamando hasta que en AsignadoMedia tengamos en el 3 contador un 0 lo cual quiere decir que hemos revisado todas las atenciones que hemos hecho a lo largo de la jornada
    ?x <- (MediaTE ?contador ?sumatoria)
    ?y <- (AsignadoMedia TE ?m ?t)
    =>
    (assert (MediaTE (+ ?contador 1) (+ ?sumatoria ?t)))
    (if (eq ?m 0) then
      (assert (ImprMediaTE))
    )
    (if (neq ?m 0) then
      (assert (AsignadoMedia TE (- ?m 1) ?t))
    )
    (retract ?x ?y)
  )

  (defrule ImprimirMediaTE                ; Tan solo nos vale para imprimir
    ?x <- (ImprMediaTE)
    ?y <- (MediaTE ?contador ?sumatoria)
    =>
    (assert (MediaTED ?contador ?sumatoria))
    (printout t "La media de tiempo en los tramites específicos es de " (/ ?sumatoria ?contador) crlf)
    (retract ?x ?y)
  )

  (defrule calculaDesviacionTG            ; Calculamos la desviación gracias al contador que hemos ido formando con el calculo de la media (MediaTGD)
    ?x <- (DesviacionTG ?contador1 ?sumatoria1)
    (MediaTGD ?contador ?sumatoria)
    =>
    (printout t "La Desviacion de tiempo en los tramites generales es de " (/ ?sumatoria (+ ?contador 1)) crlf)
    (retract ?x)
  )

  (defrule calculaDesviacionTE            ; Calculamos la desviación gracias al contador que hemos ido formando con el calculo de la media (MediaTED)
    ?x <- (DesviacionTE ?contador1 ?sumatoria1)
    (MediaTED ?contador ?sumatoria)
    =>
    (printout t "La Desviacion de tiempo en los tramites específicos es de " (/ ?sumatoria (+ ?contador 1)) crlf)
    (retract ?x)
  )

  ;;;;;;; Ejercicio 3

  (defrule fichaje                                            ; Ejecutaremos esto una sola vez, cuando fichamos, en el momento que ficha el empleado se encienden las luces de su oficina
    (Ficha ?empl)                                             ; pero esto no quiere decir que estén siempre encendidas pues se apagarán cuando salga de su oficina y no halla nadie en ella
    ?x <- (Ficho ?empl 0)                                     ; esto es una simple decisión de diseño pero es importante recalcar que la oficina no esatrá siempre encendida, solo cuando tengamos gente.
    ?y <- (Esta ?empl 0)                                      ; Cambiamos el estado del empleado y vamos contabilizando el número de personas que hay en cada oficina, empezando aquí.
    ?z <- (estadoEmpleado (empleado ?empl) (estado NOLLEGO) (numeroTramites ?nt) (tiempoTotal ?tt) (salidas ?sal))
    (Empleado ?empl ?oficina)
    ?te <- (cantidad ?oficina ?as ?bs)
    =>
    (assert (Ficho ?empl 1))
    (assert (Esta ?empl 1))
    (assert (enciendeLuz ?oficina)) ; Luces
    (assert (cantidad ?oficina (+ ?as 1) ?bs))
    (modify ?z (estado LLEGO))
    (retract ?x ?y ?te)
  )

  (defrule PrimerEncendido                                     ; Esto es para el primer encendido de las oficinas, cuando hay cero personas dentro y alguien ficho anteriormente, esto solo es para el primer encendido
    (Sensor_puerta ?oficina)
    ?y <- (enciendeLuz ?oficina)
    =>
    (printout t "Luces de " ?oficina " encendidas" crlf)
    (retract ?y)
  )

  (defrule sale                                               ; Aquí controlamos cuando un empleado se va de su oficina para ir a descansar, no para ir a otra oficina, hace referencia a cuando
    ?p <-(seva ?empl ?h ?m ?s)                                ; un empleado sale del establecimiento, por supuesto apagamos la luz de su oficina pues si se va no habrá nadie más en ella,
    ?y <- (Esta ?empl 1)                                      ; cambiamos su estado y contabilizamos que hay 0 personas en la oficina
    (Ficho ?empl 1)
    (Empleado ?empl ?oficina)
    ?w <- (Luz ?oficina ON)
    ?z <- (estadoEmpleado (empleado ?empl) (estado ?e) (numeroTramites ?nt) (tiempoTotal ?tt) (salidas ?sal))
    ?te <- (cantidad ?oficina ?as ?bs)
    (Sensor_presencia Pasillo)
    (Sensor_puerta ?oficina)
    =>
    (assert (Esta ?empl 0))
    (assert (horasalidas ?h ?m))
    (assert (Luz ?oficina OFF)) ; Luces
    (assert (cantidad ?oficina (- ?as 1) ?bs))
    (printout t "Luces de " ?oficina " apagadas" crlf)
    (assert (salio ?empl))
    (modify ?z (estado DESCANSANDO))
    (retract ?y ?w ?te ?p)
  )

  (defrule ApagarNadie                                         ; Apaga la luz de la oficina cuando no hay nadie en ella
    (cantidad ?oficina 0 ?n)
    ?x <- (Luz ?oficina ON)
    =>
    (assert (Luz ?oficina OFF))
    (printout t "Luces de " ?oficina " apagadas")
    (retract ?x)
  )

  (defrule llego                                                ; Enciende luces, controla el número de personas en la habitación y modifica el estado del empleado para saber que llego
    ?p <- (llega ?empl ?h ?m ?s)                                ; marcamos al empleado como que esta pues esto nos valdrá para sacar estadísticas
    ?x <- (horasalidas ?h ?m)
    ?y <- (Esta ?empl 0)
    (Ficho ?empl 1)
    ?w <- (salio ?empl)
    ?k <- (estadoEmpleado (empleado ?empl) (estado ?e) (numeroTramites ?nt) (tiempoTotal ?tt) (salidas ?sal))
    ?j <- (Luz ?oficina OFF)
    ?te <- (cantidad ?oficina ?as ?bs)
    (Sensor_puerta ?oficina)
    =>
    (assert (Esta ?empl 1))
    (assert (Luz ?oficina ON)) ; Luces
    (assert (cantidad ?oficina (+ ?as 1) ?bs))
    (printout t "Luces de " ?oficina " encendidas" crlf)
    (modify ?k (estado LLEGO))
    (retract ?x ?y ?w ?j ?te ?p)
  )

  (defrule retrasoTrabajar                                      ; Controlamos cuando un empleado llega tarde a fichar y mandamos un aviso, tenemos una marca para que el aviso solo sea una vez
    (Ficho ?e 0)                                                ; pues en este caso no necesitamos que sea más veces con una es suficiente
    (Esta ?e 0)
    (TiempoMaximoRetraso ?t)
    (hora_actual ?h)
    (minutos_actual ?m)
    (ComienzoJornada ?z)
    (test (> (- (totalminutos ?h ?m) (totalminutos ?z 0)) ?t))
    (not (exists(marca ?e)))
    =>
    (printout t "El empleado " ?e " llega más de " ?t " minutos tarde" crlf)
    (assert (marca ?e))
  )

  (defrule retrasoDescanso                                      ; Lo mismo que la anterior pero ahora con el descanso, la marca se quitará cuando llegue, al quitar la marca en otra ocasión que
    (Ficho ?e 1)                                                ; salga también podrá volver a salir el aviso
    (Esta ?e 0)
    (TiempoMaximoDescanso ?t)
    (hora_actual ?h)
    (minutos_actual ?m)
    (horasalidas ?ho ?mi)
    (test (> (- (totalminutos ?h ?m) (totalminutos ?ho ?mi)) 1))
    (not (exists(marca1 ?e)))
    (salio ?e)
    =>
    (printout t "El empleado " ?e " lleva más de " ?t " minutos de descanso" crlf)
    (assert (marca1 ?e))
  )

  (defrule preguntarEstado              ; Saber el estado de un determinado empleado, con el hecho (preguntar EMPLEADO)
    ?x <- (pregunta ?empl)
    (estadoEmpleado (empleado ?empl) (estado ?estado) (numeroTramites ?nt) (tiempoTotal ?tt) (salidas ?sal))
    =>
    (printout t "El estado del empleado " ?empl " es " ?estado crlf)
    (retract ?x)
  )

  (defrule generaInformeDesempenio      ; Saca por pantalla el informe de desempeño de cada uno de los empleados, numero de tramites, media de tiempo en ellos y tiempo total
    ?x <- (Desempenio ?empl)
    ?y <- (estadoEmpleado (empleado ?empl) (estado ?estado) (numeroTramites ?n) (tiempoTotal ?sum) (salidas ?sal))
    =>
    (if (neq ?n 0) then
      (printout t "El empleado " ?empl " ha atendido " ?n " tramites y el total de tiempo empleado " ?sum " y el tiempo medio " (/ ?sum ?n) crlf)
    )
    (if (eq ?n 0) then
      (printout t "El empleado " ?empl " ha atendido 0 tramites y el total de tiempo empleado 0 y el tiempo medio 0" crlf)
    )
    (retract ?x ?y)
  )

;; Falta ultimo apartado del ejercicio 3

;;;;;;;; Ejercicio 4

  (defrule encenderLucesPasillo ; Enciende el pasillo, baño, al detectar presencia
    ;(Sensor_puerta ?h)
    (Sensor_presencia ?h)
    ?x <- (Luz ?h OFF)
    =>
    (assert (Luz ?h ON))
    (printout t "Luces de " ?h " encendidas" crlf)
    (retract ?x)
  )

  (defrule apagarLucesPasillo ; Apaga las luces del pasillo, baño al no detectar presencia
    (Sensor_puerta ?h)
    (not (Sensor_presencia ?h))
    ?x <- (Luz ?h ON)
    =>
    (assert (Luz ?h OFF))
    (printout t "Luces de " ?h " apagadas" crlf)
    (retract ?x)
  )

  ;;;;;;;; Ejercicio 5

  (defrule muevaSala                              ; Un empleado se desplaza a otra oficina o al baño
    ?z <- (Empleado ?empl ?sala_anterior)
    (Se_desplaza ?empl ?sala_nueva ?h ?m ?s)
    =>
    (assert (Empleado ?empl ?sala_nueva))
    (printout t "El empleado " ?empl " esta en la oficina " ?sala_nueva " la cual no es la suya, la suya es " ?sala_anterior crlf)
    (retract ?z)
  )

  (defrule papeleriaOcupada                         ; Hay un usuario en la papeleria
    (Sensor_puerta Papeleria)
    (UsuarioOficina ?tipotramite ?n Papeleria)
    =>
    (printout t "Hay un usuario en la papelería" crlf)
  )

  (defrule gerenciaOcupada                          ; Hay un usuario en la gerencia
    (Sensor_puerta Gerencia)
    (UsuarioOficina ?tipotramite ?n Gerencia)
    =>
    (printout t "Hay un usuario en la gerencia" crlf)
  )

  (defrule maxCantidadPersonasOficina               ; Se supera el umbral de personas en una oficina, según nuestro criterio
    (cantidad ?oficina ?a ?b)
    (test (> ?a ?b))
    =>
    (printout t "Hay más de " ?b " usuarios en " ?oficina crlf)
  )

  (defrule equivocacionOficina                      ; Un determinado usuario se equivoca de oficina
    ?x <- (UsuarioOficina ?tipotramite ?n ?ofic)
    ?cod <- (str-cat ?tipotramite ?n)
    (Se_desplaza ?cod ?ofi ?h ?m ?s)
    (test (neq ?ofic ?ofi))
    =>
    (printout t "Usuario " ?cod " se equivocado de oficina, tiene que ir a " ?ofic crlf)
    (retract ?x)
  )

  (defrule SalioUnaVez                              ; Gracial slot salidas del estado del empleado sabemos cuantas veces salío
    (estadoEmpleado (empleado ?empl) (estado ?e) (numeroTramites ?nt) (tiempoTotal ?tt) (salidas ?sal))
    (test (> ?sal 1))
    =>
    (printout t "El empleado " ?empl " ha salido más de una vez" crlf)
  )
