
(clear-all)

(define-model tornado_model

;; set parameters (sgp)

;;---------------------------------------
;; chunk types
;;---------------------------------------

;; Chunk to keep track of the task. goal (state) is to translate stimulus. This triggers stimulus to maginitude??
;; possible states: look-screen, encoding, translating,
(chunk-type track-task1 
	state
	complete
	)

;; information taken from the visual buffer (placed there on the interface side)
(chunk-type stimulus
	forecast
	)

(chunk-type translation
	magnitude
	)



;;---------------------------------------
;; productions
;;---------------------------------------

;; imaginal buffer holds current problem state information
;; (stimulus information (cur_forecast) is added to visual buffer by interface)
;; (interface should set goal buffer translate-stimulus state to look-screen. is this possible?)
;; encode-stimulus takes information from visual buffer and adds to imaginal

(P encode-stimulus ...
	=visual>
	forecast =cur_forecast

	?visual>
	state free

   ?imaginal>
     state free
     buffer empty

    ?goal>
    ISA track-task1
    state look-screen

==> 
goal>
	=goal>
		ISA track-task1
		state	encoding		
   +imaginal>
   		isa	stimulus
   		forecast =cur_forecast
   		)


;; 
(p translate
	=imaginal>
	forecast =cur_forecast

	?goal>
		ISA track-task1
		state encoding
...)

;;set associations between stimulus and magnitudes
;(add-dm
	;(green ISA stimulus relation in ?? )
	)
)