;;;; conversion between the values in Fahrenheit and Celsius
;;;; Lowest possible (valid) temperature is 459.67 F or 273.15
;;;; degrees Celsius - temperature of the absolute zero
;;;; C = (F - 32) * 5/9
;;;; F = C * 1.8 + 32

;;; constants declaration
(defconstant *abs-zero-fahr* 459.67)
(defconstant *abs-zero-cels* 273.15)

;;; checks if the temperature is above absolute zero
;;; takes a temperature as a number and units as symbol
;;; returns true or nil
(define temp-in-range-p (temp units)
	(if (and (symbolp units)
		(numberp temp))
	(cond ((eq units 'F)
		(if (not (< temp *abs-zero-fahr*))
			(* 5/9 (temp - 32))))
	((eq units 'C)
		(if (not (< temp *abs-zero-cels*))
			(+ 32 (* 1.8 temp))))
	(t nil))))