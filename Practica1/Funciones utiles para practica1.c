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
