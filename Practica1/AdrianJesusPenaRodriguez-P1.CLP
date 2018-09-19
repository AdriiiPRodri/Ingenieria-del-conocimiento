; vvvvvv Hechos vvvvvv

(deffacts Habitaciones
  (Habitacion Oficina1)
  (Habitacion Oficina2)
  (Habitacion Oficina3)
  (Habitacion Oficina4)
  (Habitacion Oficina5)
  (Habitacion Oficina_de_gerencia)
  (Habitacion Oficina_doble)
  (Habitacion Oficina_de_papeleria)
  (Habitacion Banio_de_mujeres)
  (Habitacion Banio_de_hombres)
  (Habitacion Recepcion)
  (Habitacion Pasillo)
)

(deffacts Puertas
  (Puerta PuertaOficina1 Pasillo)
  (Puerta PuertaOficina2 Pasillo)
  (Puerta PuertaOficina3 Pasillo)
  (Puerta PuertaOficina4 Pasillo)
  (Puerta PuertaOficina5 Pasillo)
  (Puerta PuertaOficina_de_gerencia Pasillo)
  (Puerta PuertaOficina_doble Pasillo)
  (Puerta PuertaOficina_de_papeleria Pasillo)
  (Puerta PuertaBanio_de_mujeres Pasillo)
  (Puerta PuertaBanio_de_hombres Pasillo)
  (Puerta PuertaRecepcion Pasillo)
  (Puerta PuertaPasillo Pasillo)
)

(deffacts Empleados
  (Empleado G1 Oficina1)
  (Empleado G2 Oficina2)
  (Empleado G3 Oficina3)
  (Empleado G4 Oficina4)
  (Empleado G5 Oficina5)
  (Empleado E1 Oficina_dobleMesa1)
  (Empleado E2 Oficina_dobleMesa2)
)

(deffacts Tareas
  (Tarea G1 TG)
  (Tarea G2 TG)
  (Tarea G3 TG)
  (Tarea G4 TG)
  (Tarea G5 TG)
  (Tarea E1 TE)
  (Tarea E2 TE)
)

; Esperando me sirve para comparar el numero de personas que están esperando por el tiempo medio de atención a los minutos restantes
; y de este modo solo coger solicitudes si basandonos en el tiempo medio nos da tiempo atenderlas

(deffacts inicializar
  (ultimoUsuario TG 0)
  (ultimoUsuario TE 0)
  (ultimoUsuarioAtendido TG 0)
  (ultimoUsuarioAtendido TE 0)
  (esperando 0)
)

; Tiempo Medio de atención por usuario = 10
; Tenemos que nuestro horario de Apertura es de 8 a 21 y de atendición de 9 a 21
(deffacts Tiempo
  (Medio 10)
  (Apertura 8)
  (Atencion 9)
  (Clausura 16)
)

; ^^^^^^ Hechos ^^^^^^

; vvvvvv Funciones vvvvvv

(deffunction system-string (?arg)
   (bind ?arg (str-cat ?arg " > temp.txt"))
   (system ?arg)
   (open "temp.txt" temp "r")
   (bind ?rv (readline temp))
   (close temp)
   ?rv
)

(deffunction hora ()
  (bind ?rv (integer (string-to-field (sub-string 1 2  (system-string "time /t")))))
  ?rv
)

(deffunction minutos ()
  (bind ?rv (integer (string-to-field (sub-string 4 5  (system-string "time /t")))))
  ?rv
)

(deffunction mrest (?arg)
  (bind ?rv (+ (* (- (- ?arg 1) (hora)) 60) (- 60 (minutos))))
  ?rv
)

; ^^^^^^^ Funciones ^^^^^^^

; vvvvvv Reglas vvvvvv

(defrule malTramite
  ?g <- (Solicitud ~TG & ~TE)
  =>
  (retract ?g)
  (printout t "El tramite solicitado no se realiza aqui" crlf)
)

; En esta función al igual que en la siguiente con el tema del tiempo lo que hago es que tengo un hecho que es esperando y este hecho lo que hace es indicar
; el número de personas que hay esperando ya que por cada una se requieren 10 minutos, entonces si por ejemplo quedan 60 minutos para atender
; y hay actualmente 5 personas esperando, el sistema dejará que se ponga en cola una sola persona más.
; En caso de que acaben antes de lo previsto de atender, lo que ocurrirá es que el sistema volverá a dejar que entren solicitudes pues
; aún quedaría tiempo, siempre se comprobaría el tiempo de nuevo.
; El contador tiene (+ ?u 1) porque cuenta como si dejasé entrar a la persona actual
; También comprobamos que nadie puede meter una solicitud antes del periodo de atención de nuestra oficina
(defrule noQuedaTiempo
  ?b <- (Solicitud ?TT)
  (Clausura ?fin)
  (Medio ?m)
  (esperando ?u)
  (Atencion ?a)
  (test (> (* ?m (+ ?u 1)) (mrest ?fin)))
  (test (> (hora) ?a))
  =>
  (printout t "Lo sentimos, no queda tiempo para atenderle, vuelva mañana." crlf)
  (retract ?b)
)

(defrule esDemasiadoPronto
  ?b <- (Solicitud ?TT)
  (esperando ?u)
  (Atencion ?a)
  (test (< (hora) ?a))
  =>
  (printout t "Lo sentimos, es demasiado pronto para atenderle, vuelva a las " ?a crlf)
  (retract ?b)
)

; Comprobamos que el tiempo que nos queda sea >= que el tiempo medio por los usuarios esperando más el usuario que acaba de solicitar

(defrule enCola
  ?g <- (Solicitud ?TT)
  ?f <- (ultimoUsuario ?TT ?n)
  (Clausura ?fin)
  (test (< (hora) ?fin))
  (Medio ?m)
  ?k <- (esperando ?u)
  (test (<= (* ?m (+ ?u 1)) (mrest ?fin)))
  (Atencion ?a)
  (test (> (hora) ?a))
  =>
  (assert (Usuario ?TT (+ ?n 1)))
  (assert (esperando (+ ?u 1)))
  (retract ?f ?g ?k)
  (assert (ultimoUsuario ?TT (+ ?n 1)))
  (printout t "ID asignado " (+ ?n 1) crlf)
)

; Se atenderá en orden de cola gracias a la sentencia (test (eq ?n (+ ?m 1))) que compara que el usuario escogido tenga el id siguiente al ultimo atendido

(defrule atender
  ?e <- (Tarea ?empl ?TT)
  ?x <- (Disponible ?empl)
  ?y <- (ultimoUsuarioAtendido ?TT ?m)
  ?h <- (Usuario ?TT ?n)
  (test (eq ?n (+ ?m 1)))
  (Empleado ?empl ?hab)
  ?k <- (esperando ?j)
  =>
  (assert (ultimoUsuarioAtendido ?TT (+ ?m 1)))
  (assert (esperando (- ?j 1)))
  (printout t "Usuario " ?n " pase a la " ?hab ", le atendera el empleado " ?empl crlf)
  (retract ?h ?x ?y ?k)
)

; ^^^^^^ Reglas ^^^^^^
