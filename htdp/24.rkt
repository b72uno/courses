;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |24|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;;  ---------------------------
;;          Section 24
;; ----------------------------

;; Intermezzo 4: Defining Functions on the Fly


;; find : list-of-IRs symbol  ->  boolean
;(define (find aloir t)
;  (local ((define (eq-ir? ir p)
;	    (symbol=? (ir-name ir) p)))
;    (filter1 eq-ir? aloir t)))

;An alternative arrangement places the local-expression 
;where the function is needed:

;; find : list-of-IRs symbol  ->  boolean
;(define (find aloir t)
;  (filter1 (local ((define (eq-ir? ir p)
;		     (symbol=? (ir-name ir) p)))
;	     eq-ir?)
;           aloir t))


;A lambda-expression is just a new form of expression:
;
;<exp>	=	(lambda (<var> ... <var>) <exp>)
;Its distinguishing characteristic is the keyword lambda. 
;It is followed by a sequence of variables, enclosed in a
;pair of parentheses. The last component is an expression.
;
;Here are three useful examples:
;
;(lambda (x c) (> (* x x) c))
;
;(lambda (ir p) (< (ir-price ir) p))
;
;(lambda (ir p) (symbol=? (ir-name ir) p))

;They correspond to squared?, <ir, and eq-ir?, respectively, 
;the three motivating examples discussed above.

;A lambda-expression defines an anonymous function, that is, 
;a function without a name. The sequence of variables behind 
;lambda are the function's parameters; the third component 
;is the function's body.



; A lambda-expression is a value because functions are values.
;
; The application of lambda-expressions to values proceeds 
; according to our usual laws of function application, 
; assuming we expand the short-hand first.
;
; Here is a sample use of lambda:
;
;  (filter1 (lambda (ir p) (< (ir-price ir) p))
;           (list (make-ir 'doll 10))
;	   8)


;; ((lambda (x-1 ... x-n) exp)   
;;   val-1 ... val-n)  
;;  
;;  
;;  = exp
;;    with all occurrences of x-1 ... x-n
;;    replaced by val-1 ... val-n


;; -------------------------
;;    Exercise 24.0.7.
;; -------------------------
;; Decide which are legal lambda expressions

;(lambda (x y) (x y y)) ;; legal
;
;(lambda () 10) ;; legal
;
;(lambda (x) x) ;; legal
;
;(lambda (x y) x) ;; legal
;
;(lambda x 10) ;; illegal, needs at least 1 variable, missing parentheses

;; 24.0.8 - Draw sth sth by hand, find scope and all that jazz.

;; -------------------------
;;    Exercise 24.0.9.
;; -------------------------

;; Evaluate expressions by hand
;; Not gonna happen. 


;; Pragmatics of lambda

;; THE GENERAL GUIDLINE ON USING LAMBDA EXPRESSIONS:
;; - Use lambda-expressions when a function is not recursive and is
;; only needed once in an argument position.



