;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |9.4|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))
;; **************************************************
;; Designing functions for self-refential data def-s
;; **************************************************

;(define (fun-for-los a-list-of-symbols)
;  (cond
;    [(empty? a-list-of-symbols) ...]
;    [else ... (first a-list-of-symbols) ...
;      ... (fun-for-los (rest a-list-of-symbols)) ...]))

;; We refer to self-applications in the templates 
;; as NATURAL RECURSIONS

;; Conditional clauses that do not contain natural recursions
;; we refer to as BASE CASES

;; how-many : list-of-symbols -> number
;; to determine how many symbols are on a-list-of-symbols
;(define (how-many a-list-of-symbols)
;  (cond
;    [(empty? a-list-of-symbols) 0]
;    [else (+ (how-many (rest a-list-of-symbols)) 1)]))


;; Data analysis & design:
;; (define (sum a-list-of-numbers))
;; sum is a function which sonsumes a list of numbers
;; and adds them up

;; Contract, Purpose & Header:
;; sum : a-list-of-numbers -> number
;; to determine the sum of numbers on a-list-of-numbers 

;; Examples: see tests

;; Template:
;(define (fun-for-lon a-list-of-numbers) 
;  (cond
;    [(empty? a-list-of-numbers) ...]
;    [else ... (first a-list-of-numbers) ... 
;          ... (fun-for-lon (rest a-list-of-numbers)) ... ]
    
;; Definition:
(define (sum a-list-of-numbers)
  (cond
    [(empty? a-list-of-numbers) 0]
    [else (+ (sum (rest a-list-of-numbers)) 
               (first a-list-of-numbers))]
    ))

;; Tests:
;(= (sum empty) 0)
;; expected value: true

;(= (sum (cons 1.0 empty)) 1.0)
;; expected value: true

;(= (sum (cons 17.05 (cons 1.22 (cons 2.59 empty)))) 20.86)
;;expected value: true

;; Definition:
(define (how-many? a-list-of-anything)
  (cond
    [(empty? a-list-of-anything) 0]
   [else (+ (how-many? (rest a-list-of-anything)) 1 )]
    ))
;; to determine how many numbers / symbols are in a function
;; as a list can consume any values, it does not matter what
;; kind of data we are dealing with, all we want to find out
;; is how many items are in the list
;(= (how-many? empty) 0)
;; expected value: true

;(= (how-many? (cons 1 empty)) 1)
;; expected value: true

;(= (how-many? (cons 17.05 (cons 'shishkebab (cons true empty)))) 3)
;; expected value: true

;(define (dollar-store? a-list-of-numbers threshold)
;  (cond
;    [(empty? a-list-of-numbers) true]
;    [else (and
;           (< (first a-list-of-numbers) threshold)
;           (dollar-store? (rest a-list-of-numbers) threshold))]))
;    
;(dollar-store? empty 1)
;(not (dollar-store? (cons .75 (cons 1.95 (cons .25 empty))) 1))
;(dollar-store? (cons .15 (cons .05 (cons .25 empty))) 1)
;; expected values: 3x true

;; Data analysis & design
;; (define (convert a-list-of-digits))
;; convert is a function which consumes a list of digits
;; and produces the corresponding number starting
;; with the least significant digit

;; Contract, Header & Purpose
;; convert : a-list-of-digits -> number
;; to convert a list of digits into a number

;; Examples: see tests

;; Template, Definition and I am tired of writing documentation
;; I promise to write it for challenging problems though :)

;; Now to get trough this chapter....
(define (convert a-list-of-digits) 
  (cond
    [(empty? a-list-of-digits) 0]
    [else (+ (first a-list-of-digits) 
             (* (convert (rest a-list-of-digits)) 10
                ))]))

(define (check-guess-for-list a-list-of-digits target)
  (cond
    [(> (convert a-list-of-digits) target) 'TooLarge]
    [(< (convert a-list-of-digits) target) 'TooSmall]
    [(= (convert a-list-of-digits) target) 'Perfect]
    [else 'NothingHereTakeAHike]
    ))

(define (delta initial-list end-list)
  (-
   (sum initial-list)
   (sum end-list)))

(define (average-price list-of-toys)
  (cond
   [(empty? list-of-toys) 'DivisionByZeroEndOfTheWorldInitiated]
   [else
  (/ (sum list-of-toys)
     (how-many? list-of-toys))]))


;; Data analysis & design:
;; (define (draw-circles posn-p list-of-numbers) ...)
;; draw-circles is a function which consumes a posn-structure
;; posn-p and a-list-of-numbers

;; Header, Contract & Purpose:
;; draw-circles : posn-p a-list-of-numbers -> graphical output / boolean values
;; to draw a bunch of circles with a center of posn-p
;; and radii contained in the list of number; outputs boolean
;; value depending whether the function succeeds or not

;; Template:
;(define (draw-circles posn-p list-of-numbers) ...
;   ... (posn-x posn-p) ....
;   ... (posn-y posn-p) ....
;   ... (first list-of-numbers) ...
;   ... (rest list-of-numbers) ... )

;; Examples: see tests


;; Definition:
(define (draw-circles posn-p list-of-numbers) 
  (cond 
    [(or
      (empty? list-of-numbers)
      (or
       (< (posn-x posn-p) 0)
       (< (posn-y posn-p) 0)
       )) false]
    [else
     (and (draw-circle (make-posn (posn-x posn-p) (posn-y posn-p)) (first list-of-numbers) 'Blue)
     (draw-circles posn-p (rest list-of-numbers)))]))



;; Tests:
(start 500 500)
(draw-circles (make-posn 250 250) (cons 50 (cons 30 (cons 40 (cons 20 (cons 100 empty))))))
;; expected value:
;true



