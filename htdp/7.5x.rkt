;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 7.5x) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; Data definitions
(define-struct vec (x y))
;; vec is a structure (make-vec x y) where 
;; x and y are positive numbers

;; Contract & Purpose
;; make-vec number number -> vec-struct
;; to create a structure speed-vector (vec) 
;; according to x and y inputs

;; Template
;; (define (f a-vec)
;;     ... (vec-x a-vec) ...
;;     ... (vec-y a-vec) ...)

;; Definition:
(define (checked-make-vec a-vec)
  (cond
    [(and 
      (number? (vec-x a-vec))
      (number? (vec-y a-vec))
      ) (cond
         [(and (> (vec-x a-vec) 0)
               (> (vec-y a-vec) 0)
             ) (make-vec (vec-x a-vec) (vec-y a-vec))]
         [else (error 'checked-make-vec "POSITIVE nubmer expected")])]
    [else (error 'checked-make-vec "number expected")]))

;; Tests
;(checked-make-vec (make-vec 'asd 'ad))
;; expected value:
(checked-make-vec (make-vec -25 0))
;; Expected value:

   