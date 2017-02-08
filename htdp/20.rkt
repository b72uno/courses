;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |20|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;  ---------------------------
;;          Section 20
;;     Functions are Values
;;     Syntax and semantics
;; -----------------------------


;; 20.1.1-2 were some thought provoking questions
;; not sure that I really uderstood them. Will have
;; to look up what others have responded on those
;; questions.

;; -------------------------
;;    Exercise 20.1.3.
;; -------------------------

;; Develop a-function=? which determines whether two
;; functions numbers to numbers produce the same results
;; for 1.2,3 and 5,7

(define (f1 x y)
  (+ x y))

(define (f2 x y)
  (+ x y))

;; a-function=? (number number -> X) (number number -> X) -> boolean
(define (a-function=? function1 function2 n1 n2 n3 n4)
  (and
    (equal? (function1 n1 n2) (function2 n1 n2))
    (equal? (function1 n3 n4) (function2 n3 n4))))

; 
;(a-function=? f1 f2 1.2 3 -5 7)
  
;; k I guess im stupid as a rock, yep I am. Had set language to beginner student.
;; Thats what u get when u delete the top line or dont create one when writing in vim


;; -------------------------
;;    Exercise 20.2.1.
;; -------------------------

;; Explain the following classes of functions:
;; (number -> boolean) consumes a number, produces boolean
;; (boolean symbol -> boolean) consumes a boolean and a symbol, produces boolean
;; (number number number -> number) consumes 3 numbers and produces also a number
;; (number -> (listof number)) consumes a number and produces a list of number
;; ((listof number) -> boolean) consumes a list of number and produces boolean

;; -------------------------
;;    Exercise 20.2.2.
;; -------------------------

;; Formulate contracts for following functions:
;;
;; sort, consumes lon and a f that consumes 2x # and produces a bool, sort produces a lon
;; sort : (listof number) (number number -> boolean) -> (listof number)

;; map, consumes  a f from # to # and a lon, also produces a lon
;; map : (number -> number) (listof number) -> (listof number)

;; project, consumes lists of lists of symbols and a f from lists of symbols to symbols and
;; produces a list of symbols
;; project : (listof (listof symbols)) ((listof symbols) -> symbols) -> (listof symbols)

;; -------------------------
;;    Exercise 20.2.3.
;; -------------------------

;; use filter1 to develop a f that consumes a list of symbols and extracts all those
;; that are not equal to 'car. Give filter1's corresponding contract.

;; filter1 : (X X -> boolean) (listof X) X -> (listof X)
(define (filter1 predicate alon t)
  (cond
    [(empty? alon) empty]
    [else (cond
          [(predicate (first alon) t)
          (cons (first alon) (filter1 predicate (rest alon) t))]
          [else (filter1 predicate (rest alon) t)])]))

;; extractcar : (symbol symbol -> boolean) (listof symbol) symbol -> (listof symbol) 
(define (extractcar predicate los s)
  (filter1 predicate los s))


; (check-expect (extractcar equal? (list 'herp 'derp 'car 'molly 'car 'caragain 'notrly) 'car) (list 'car 'car))

;; -------------------------
;;    Exercise 20.2.4.
;; -------------------------

;; Formulate general contracts for following functions:
;; sort, which consumes a list and a function that consumes two items from the list and produces a boolean,
;; sort itself produces a list of numbers
;; sort : (listof X) (X X -> boolean) -> (listof X)

;; map, which consumes a function from list items to xs and and a list; it produces a list of xs
;; map : ((listof ITEMS) -> X) list -> (listof X)

;; project, which consumes a list of lists and a function from lists to xs, it produces a list of xs
;; project : (listof (listof X)) ((istof X) -> X) -> (listof X)


;;IN SUMMARY:
;;the contracts of functions are made up of TYPES
;;a TYPE is either:
;;1. a basic type such as number symbol boolean or empty
;;2. a defined type such as inventory-record, list-of-numbers or family-tree
;;3. a function type such as (number -> number) or (boolean -> symbol)
;;4. a parametric type, which is either a defined type or a function type with variables
;;
;; When we wish to use a function with parametric type, we must first find a replacement for all
;; varibles, in the functions contract so that we know the arguments belong to proper classes.
;; If this cannot be done, we must either revise the contract or question our decision to reuse this 
;; function.
