;;;; conversion between the values in Fahrenheit and Celsius
;;;; Lowest possible (valid) temperature is -459.67 F or -273.15
;;;; degrees Celsius - temperature of the absolute zero
;;;; C = (F - 32) * 5/9
;;;; F = C * 1.8 + 32

;;; constants declaration
(defconstant *abs-zero-fahr* -459.67)
(defconstant *abs-zero-cels* -273.15)

;;; round/floor/ceil/trunk to a certain precision
(defun round-to (number precision &optional (fn #'round))
	(let ((div (expt 10 precision)))
		(/ (funcall fn (* number div)) div 1.0)))

;;; checks if the temperature is above absolute zero
;;; takes a temperature as a number and units as symbol
;;; returns true or nil
(defun temp-in-range-p (temp &optional (units 'F))
	(if (and (symbolp units)
		(numberp temp))
	(cond ((eq units 'F)
		(if (not (< temp *abs-zero-fahr*))
			t))
	((eq units 'C)
		(if (not (< temp *abs-zero-cels*))
			t))
	(t nil))))

;;; converts single value F to C
(defun fahrenheit-to-celsius (temp &optional (precision 2))
	(and (temp-in-range-p temp 'f)
		(integerp precision)
		(>= precision 0)
		(round-to (* 5/9 (- temp 32)) precision)))

;;; converts single value C to F
(defun celsius-to-fahrenheit (temp &optional (precision 2))
	(and (temp-in-range-p temp 'c)
		(integerp precision)
		(>= precision 0)
		(round-to (+ 32 (* 1.8 temp)) precision)))

;;; converts a list or vector of F values to a vector or list (default) of C values
;;; accepts  &key precision (integer) with default of 2 and result type - 
;;; list (default) or vector
(defun fahrenheit-to-celsius-seq (temp-seq &key (precision 2) (result-type 'list))
	(map result-type #'(lambda (x) (fahrenheit-to-celsius x precision)) temp-seq))

;;; converts a list or vector of C values to a vector or list (default) of F values
;;; accepts &key precision (integer) with default of 2 and 
;;; result type - list (default) or vector
(defun celsius-to-fahrenheit-seq (temp-seq &key (precision 2) (result-type 'list))
	(map result-type #'(lambda (x) (celsius-to-fahrenheit x precision)) temp-seq))

;;; combined F-to-C converter. 
;;; Accepts:
;;; 	single value, list, or vector of temperatures
;;; 	&key sympbols 'F or 'C (defaults to 'F)
;;; 	&key precision (defaults to 2)
;;;		&key result-type (defaults to 'list for sequences)
(defun fahrenheit-celsius (temp &key (from 'F) (precision 2) (result-type 'list))
	(cond ((numberp temp)
		(cond ((eq from 'F)
			(fahrenheit-to-celsius temp precision))
		((eq from 'C)
			(celsius-to-fahrenheit temp precision))
		(t nil)))
	((or (listp temp) (vectorp temp))
		(cond ((eq from 'F)
			(fahrenheit-to-celsius-seq 
				temp 
				:precision precision 
				:result-type result-type))
		((eq from 'C) 
			(celsius-to-fahrenheit-seq
				temp
				:precision precision
				:result-type result-type))
		(t nil)))
	(t nil)))

;;; tests for fahrenheit-celsius
; (print (fahrenheit-celsius 98))
; (print (fahrenheit-celsius 37.2 :from 'C))
; (print (fahrenheit-celsius 98 :precision 3))
; (print (fahrenheit-celsius 37.23 :from 'C :precision 3))
; (print (fahrenheit-celsius 37.23 :from 'C :precision 3 :result-type 'vector))
; (print (fahrenheit-celsius '(76 98)))
; (print (fahrenheit-celsius '(37.2 39) :from 'C))
; (print (fahrenheit-celsius '(76 98) :precision 3))
; (print (fahrenheit-celsius '(37.2 39) :from 'C :precision 3))
; (print (fahrenheit-celsius #(37.2 39) :from 'C :precision 3 :result-type 'vector))

; ;;; tests for seq functions
; (print (celsius-to-fahrenheit-seq '(10 20 30 40 98.6)))
; (print (celsius-to-fahrenheit-seq '(10 20 30 40 98.6) :precision 3))
; (print (celsius-to-fahrenheit-seq '(10 20 30 40 98.6) :result-type 'vector))
; (print (celsius-to-fahrenheit-seq #(10 20 30 40 98.6) :precision 3))
; (print (celsius-to-fahrenheit-seq #(10 20 30 40 98.6) :result-type 'vector))

; (print (fahrenheit-to-celsius-seq '(10 20 30 40 98.6)))
; (print (fahrenheit-to-celsius-seq '(10 20 30 40 98.6) :precision 3))
; (print (fahrenheit-to-celsius-seq '(10 20 30 40 98.6) :result-type 'vector))
; (print (fahrenheit-to-celsius-seq #(10 20 30 40 98.6) :precision 3))
; (print (fahrenheit-to-celsius-seq #(10 20 30 40 98.6) :result-type 'vector))

;;; tests for temp-in-range-p
; (print (temp-in-range-p -459.67 'f))
; (print (temp-in-range-p -459.68 'f))
; (print (temp-in-range-p -459.67))
; (print (temp-in-range-p -459.68))
; (print (temp-in-range-p -273.15 'c))
; (print (temp-in-range-p -273.16 'c))
; (print (temp-in-range-p 0 'f))
; (print (temp-in-range-p 459.67 'f))
; (print (temp-in-range-p 459.67))
; (print (temp-in-range-p 459.67 'c))

;; tests for celsius-to-fahrenheit
; (print (= (celsius-to-fahrenheit 0) 32))
; (print (= (celsius-to-fahrenheit 10) 50))
; (print (= (celsius-to-fahrenheit -10) 14))
; (print (= (celsius-to-fahrenheit -273.15) -459.67))
; (print (equal (celsius-to-fahrenheit -300) nil))
; (print (equal (celsius-to-fahrenheit 10 3.4) nil))
; (print (equal (celsius-to-fahrenheit 10 -3) nil))
; (print (= (celsius-to-fahrenheit 0 3) 32))
; (print (celsius-to-fahrenheit 0 3))


; ;;; tests for fahr-to-cels
; (print (= (fahrenheit-to-celsius 32) 0))
; (print (= (fahrenheit-to-celsius 50) 10))
; (print (= (fahrenheit-to-celsius 14) -10))
; (print (= (fahrenheit-to-celsius -459.67) -273.15))
; (print (equal (fahrenheit-to-celsius -500) nil))
; (print (equal (fahrenheit-to-celsius 10 3.4) nil))
; (print (equal (fahrenheit-to-celsius 10 -3) nil))
; (print (= (fahrenheit-to-celsius 32 3) 0))
; (print (fahrenheit-to-celsius 0 3))



