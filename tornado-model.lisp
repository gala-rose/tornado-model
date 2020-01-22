
(clear-all)

(define-model tornado-model

;; set parameters (sgp)

;;---------------------------------------
;; chunk types
;;---------------------------------------

;; Chunk to keep track of the first task (tracking from seeing stimulus to determining magnitude) in goal module. Three possible entries for state slot: look-screen, encoding, translating.
(chunk-type goal
			state ;;look-screen, encoding, translating
			decision ;;yes/no. whether a decision to shelter or not shelter was made or not
	)

;; stimulus chunk is information about the forecast taken from the visual buffer. Forecasts are broken down by individual symbols (e.g. the symbol of orange, the symbol of 25%, etc.). Some forecasts have up to three components (A, B, C)
(chunk-type stimulus
	forecastA 
	forecastB 
	forecastC 
	numberA
	numberB
	color
	word
	)

;; This chunk represents a magnitude (preloaded - think of as real-world knowledge) associated with colors, numbers, and words.
(chunk-type magnitude
	magnitude
	number
	color 
	word
	)

;;---------------------------------------
;; preload chunks - include a sample magnitudes?
;;---------------------------------------
(add-dm (cur_forecast_a ISA stimulus yes)
		(make-decision ISA goal
			   state look-screen))

(set-buffer-chunk visual cur_forecast_a)

;;---------------------------------------
;; productions
;;---------------------------------------

;; Imaginal buffer holds current problem state information
;; production encode-stimulus takes information from visual buffer and adds to imaginal
(P encode-stimulus ...
	=visual>
	isa stimulus
	forecastA =cur_forecast_a
	forecastB =cur_forecast_b
	forecastC =cur_forecast_c

	?visual>
	state free

   	?imaginal>
   	state free
   	buffer empty

    ?goal>
    ISA make-decision
    state look-screen

==> 
goal>
	=goal>
	ISA 	make-decision
	state	encoding		

   +imaginal>
   	isa	stimulus
   	forecastA =cur_forecast_a
   	forecastB =cur_forecast_b
   	forecastC =cur_forecast_c
   	numberA =cur_forecast_numberA
	numberB =cur_forecast_numberB
	color =cur_forecast_color
	word =cur_forecast_word
   	)

;; production translate takes info from imaginal buffer and retrieves a magnitude based on associative strength.
(p translate
	=imaginal>
	isa	stimulus
   	forecastA =cur_forecast_a
   	forecastB =cur_forecast_b
   	forecastC =cur_forecast_c
   	numberA =cur_forecast_numberA
	numberB =cur_forecast_numberB
	color =cur_forecast_color
	word =cur_forecast_word

	?imaginal>
   	state free

	?goal>
	ISA make-decision
	state encoding

	?retrieval>
    state free
    buffer empty

 ==>  
 	=goal>
 	ISA make-decision
 	state translating

   +retrieval> 
   	ISA magntiude
   	magnitude
   	number
   	color
   	word
   	;;let imaginal clear?
	)

;; production takes magnitude and makes decision based on shelter/not shelter threshold
;; preload magnitudes. set associations?
)