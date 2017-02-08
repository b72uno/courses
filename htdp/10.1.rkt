;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |10.1|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp") (lib "guess.ss" "teachpack" "htdp")))))
;; ********************************
;;    MORE ON PROCESSING LISTS
;;   producing lists and what not
;; ********************************

;; NOTE: From now on I'm using Camel Casing only
;; I really do not feel comfortable using those
;; special characters in my f and v names mkeii?

;; hoursToWages : listOfNumbers -> listOfNumbers
;; to create a list of wekly wages from a list of 
;; weekly hours (alon)

;; Template:
;(define (hoursToWages alon) ...
;  (cond 
;    [(empty? alon) ...]
;    [(else ... (first alon) ... 
;               (hoursToWages (rest alon))...) 
;    ]))

;; Examples:
;; inputs:
;empty
;(cons 28 empty)
;(cons 40 (cons 28 empty))
;
;;; outputs:
;empty
;(cons 336 empty)
;(cons 480 (cons 336 empty))


;; Definitions:
(define (wage h)
  (cond
    [(and
      (>= h 0)
      (> h 100)) 
      (error 'Over100 "Oh, really?")]
     [else (* h 14)]))

(define (hoursToWages alon) 
  (cond 
    [(empty? alon) empty]
    [else
      (cons (wage (first alon))   
               (hoursToWages (rest alon)))]))

;; Tests:
;(hoursToWages empty)
;; expected output: empty
;(hoursToWages (cons 28 empty))
;; expected output: (cons 336 empty)
;(hoursToWages (cons 400 (cons 28 empty)))
;; expected output: error: "Too many hours"



;; *************
;;  10.1.5.
;; *************

;; Data definition & design:
;; eliminateExp :  number list -> list
;; eliminateExp is a function which consumes
;; price threshold (number) and a list of toy prices (list)
;; to produce a list of toy prices which are below the threshold

;; Contract, header & purpose:
;; eliminateExp :  number list -> list
;; to create a list out of a list of toys with different values
;; in new list all values should be below the number

;; Template:
;(define (eliminateExp threshold listOfToyPrices) ...
;  (cond
;    [(empty? listOfToyPrices) empty]
;    [else ... (first listOfToyPrices) ...
;          ... (rest listOfToyPrices) ...]))

;; Examples: see tests

;; Definition:
(define (eliminateExp threshold listOfToyPrices)
  (cond
    [(empty? listOfToyPrices) empty]
    [(< (first listOfToyPrices) threshold)
     (cons (first listOfToyPrices) 
           (eliminateExp threshold (rest listOfToyPrices)))]
    [else (eliminateExp threshold (rest listOfToyPrices))]))
          

;; Tests:
;(eliminateExp 1.0 (cons 2.95 (cons .95 (cons 1.0 (cons 5 empty)))))
;; expected value: (cons .95 (cons 1.0 empty))



;; *************************************************************
;;  FYI: CANT BE BOTHERED WITH DOCUMENTATION RIGHT NOW
;;  I AM RUNNING OUT OF TIME. I MEAN MY LIFE SPAN IS LIMITED.
;;  THEREFORE I WANT TO LEARN CONCEPTS RIGHT NOW AND 
;;  WRITE THAT BLOODY DOCUMENTATION LATER MKEEI?
;;  EXPECT SHORT DEFINITIONS AND TESTS ONLY!
;; *************************************************************


;; *************
;;  10.1.6.
;; *************

;; Data analysis, purpose and what not:
;; substitue : symbol symbol list -> list
;; substitue is a function which consumes 2 symbols: 
;; a substitor and substitutee (o rlly?) and a list of 
;; arbitrary data. Then it poopoos out a list which is 
;; exactly the same as the input one, but has all occurances
;; of first symbol replaced with the second one, mkeeeii?


;; Definition:
(define (substitute oldSymbol newSymbol list)
  (cond
    [(empty? list) empty]
    [else 
     (cons 
      (cond [(symbol=? 'doll (first list)) 'Barbie]
            [else (first list)])
      (substitute oldSymbol newSymbol (rest list)))]))
    

;; Tests:
;(substitute 'Barbie 'doll (cons 'robot (cons 'doll (cons 'dress empty))))
;; expected value: (cons 'robot (cons 'Barbie (cons 'dress empty))))


;; *************
;;  10.1.7.
;; *************

;; Data analysis & stuff
;; recall : ty lon -> lon
;; to eliminate values (ty) in a list (lon) and produce
;; a list without them

;; Definition:
(define (recall ty lon)
  (cond
   [(empty? lon) empty]
    [(symbol=? (first lon) ty)
      (recall ty (rest lon))]
    [else (cons (first lon) (recall ty (rest lon)))]))

;; Tests:
;; (recall 'robot (cons 'robot (cons 'doll (cons 'dress (cons 'robot (cons 'suckit (cons 'iwanttoworkforgoogle empty)))))))
;; expected value: (cons 'doll (cons 'dress empty))



;; *************
;;  10.1.8.
;; *************


;; Data analysis & Purpose
;; quadratic-roots : a b c -> symbol / number
;; to solve quadratic equations
;; function quadratic-roots consumes 3 numbers which stands
;; for coefficients a, b and c. 

;; Template:
;(define (quadratic-roots a b c)
;  ... a ... 
 ; .... b ... 
 ; ... c .... )


;; Definition:
(define (quadraticRoots a b c)
  (cond
    [(= a 0) 'degenerate]
    [(< (* b b) (* 4 a c)) 'none]
    [(= (* b b) (* 4 a c))
     (/ (* -1 b) (* 2 a))]
    [(> (* b b) (* 4 a c))
     (cons (/ (+ (* -1 b) (sqrt (- (* b b) (* 4 a c)))) (* 2 a))
           (cons 
           (/ (- (* -1 b) (sqrt (- (* b b) (* 4 a c)))) (* 2 a))
           empty))]
    ))
    

;; Tests:
;(quadraticRoots 2 3 4)
;; expected value 'none
;(quadraticRoots 0 5 2)
;; expected value: 'degenerate
;(quadraticRoots 1 4 4)
;; expected value: -2
;(quadraticRoots 1 8 4)
;; expected value: (cons longdec (cons longdec2 empty))




;; *************
;;  10.1.9.
;; *************

;; controller : number -> list
;; controller is a function which consumes amount of
;; cents (number) and produces a list with 5 items
;; dollar amount, 'dollar, 'and, cent amount 'cent / 'cents

;(define (controller cents)
;  (cons
;   (quotient cents 100)
;   (cons 
;    (cond [(= (quotient cents 100) 1) 'dollar]
;          [else 'dollars])
;    (cons 'and 
;          (cons (remainder cents 100)
;                (cons     
;                 (cond [(= (remainder cents 100) 1) 'cent]
;                       [else 'cents]) empty ))))))

(define (controller cents)
  (cons
   (quotient (quotient cents 100) 10)
   (cons (remainder (quotient cents 100) 10)
   (cons 
    (cond [(= (quotient cents 100) 1) 'dollar]
          [else 'dollars])
    (cons 'and 
          (cons 
           (quotient (remainder cents 100) 10)
           (cons 
            (remainder (remainder cents 100) 10)
                (cons     
                 (cond [(= (remainder cents 100) 1) 'cent]
                       [else 'cents]) empty ))))))))
;; if we need to accept values in dolars and cents
;; ex: 55.59 then we just multiply the number by 100 and 
;; proceed with our function

;; Examples & Tests:
;(controller 103)
;;expected value:
;; (cons 1 (cons 'dollar (cons 'and (cons 3 (cons 'cents empty))))
;(controller 11)
;; expected value:
;; (cons 0 (cons 'dollar (cons 'and (cons 11 (cons 'cent empty))))
;(controller 0)
;; (cons 0 (cons 'dollar (cons 'and (cons 0 (cons 'cents empty))))
            



