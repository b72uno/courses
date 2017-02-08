;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |11|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; Data analysis & design
;; (define (hellos n) ...) 
;; hellos is a function which consumes a number
;; and outputs n copies of a string 'hello

;; Contract & Purpose
;; hellos : N -> list of symbols
;; to create a list of n copies of 'hello'

;; Template
;; (define (hellos n) 
;; (cond
;; [(zero? n) ...]
;; [else ... (hellos (sub1 n)) ...] ))

;; Examples
;; (hellos 0)
;; expected value: 
;; empty
;; (hellos 2)
;; expected value:
;; (cons 'hello (cons 'hello empty))

;; Definition
(define (hellos n)
  (cond
    [(zero? n) empty]
    [else (cons 'hello (hellos (sub1 n)))]))

;; Tests:
;(hellos 0)
;(hellos 3)
;; expected values:
;; empty
;; (cons 'hello (cons 'hello (cons 'hello empty)))



;; ----------------------------


;; Data analysis & design
;; (define (repeat n symbol))
;; repeat is a function which consumes x and y where x is a natural number
;; and y is a symbol

;; Purpose & Contract
;; repeat : n symbol -> list
;; repeat consumes a natural number n and a symbol
;; and then outputs a list containing n items of that symbol

;; Examples
;; (repeat 0 'nyancat)
;; expected value: empty
;; (repeat 2 'nyancat)
;; expected value: (cons 'nyancat (cons 'nyancat empty))

;; Template
;;(define (repeat n symbol)
;;  (cond
;;    [(zero? n) ...]
;;    [else ... (repeat (sub1 n) symbol) ...]))

;; Definition
(define (repeat n symbol)
  (cond
    [(zero? n) empty]
    [else (cons symbol (repeat (sub1 n) symbol)) ]))

;; Tests:
;(repeat 0 'nyancat)
;(repeat 2 'nyancat)
;; expected values:
;; empty
;; (cons 'nyancat (cons 'nyancat empty))


;; ----------------------------

(define (f x)
  (+ (* 3 (* x x))
     (+ (* -6 x)
        -1)))

;; Data analysis & design
;; (define (tabulate-f n) ...)
;; tabulate-f is a function which consumes
;; a natural number n and tabulates the values of
;; f (see up above) and corresponding number

;; Purpose & Contract
;; tabulate-f : number -> list
;; tabulate-f consumes a number n and produces a list of
;; n posns

;; Examples
;; (f 2)
;; expected value:
;; (cons (make-posn 2 -1) (cons (make-posn 1 -4) empty)))

;; Template
;(define (tabluate-f n) ...
;  (cond
;    [(zero? n) ...]
;    [else ... (sub1 n) ...]))

;; Definition
(define (tabulate-f n)
  (cond
    [(< n 0) empty]
    [else (cons (make-posn n (f n)) (tabulate-f (sub1 n)))]))

;; Tests:
;(tabulate-f 5)
;; expected value:
;; like in example, just first tabulated # to 5 should be 44.
;; then the last 3 ones like in example


;; ----------------------------

;; ## DEEP LIST ##
;; 

(define n 0)
(define list1 (cons 'item1 (cons 'item2 (cons 'item3 (cons 'item4 (cons 'item5 empty))))))
(define list2 (cons 'duh empty))
;; Data analysis & design:
;; A deep-list is eitherL
;; 1. s where s is some symbol or;
;; 2. (cons dl empty) where dl is a deep list
;; (define (depth dl) ...)
;; depth is a function which determines how many
;; times cons was used to construct it

;; Contract & purpose:
;; depth: deep-list -> number
;; depth is a function which consumes a deep list
;; and outputs a number which represents how many cons
;; were used to make the list


;; Examples:
;; (depth (cons item1 (cons item2 (cons item3 (cons item4 (cons item5))))
;; expected value: 5

;; Template:
; (define (depth list)
;   (cond
;     [(empty? list) ... ]
;     [else ...]))

;; Definition:
(define (depth list)
  (cond
    [(empty? list) n]
    [else (+ (+ n 1)(depth (rest list)))]))


;; Data analysis & design:
;; (define (make-deep s n))
;; make-deep is a function where s is a symbol
;; and n is a integer. Function constructs a list
;; of symbols s using n conses

;; Contract & purpose
;; make-deep : s n -> list
;; To construct a list from symbol s with n conses

;; Examples:
;; (make-deep 'item1 5)
;; expected value:
;; (cons item1 (cons item1 (cons item1 (cons item1 (cons item1)))

;; Template:
;; (define (make-deep s n)
;; (cond
;;   [(<= n 0) ... ]
;;   [else ... ] ))

;; Definition:
(define (make-deep s n)
  (cond
    [(zero? n) empty]
    [else (cons s (make-deep s (sub1 n)))]))

;; Tests
;; See example


;; ----------------------------

;; ## EXTENDED EXERCISE 11.3. ##
;; 
;; random : N -> N
;; to compute a natural number between 0 and n - 1

;; random-n-m : interger integer -> integer
;; To compute output integer by adding the first integer
;; to the random number between 0 and difference of second and first
;; integers. 
;; Number line: .....n||||||||||||m.. 
;; the computed number always is going to be somewhere between n and m
;; assuming that n < m of course, because random wont accept negative numbers
;; Assume n < m
 (define (random-n-m n m)
(+ (random (- m n)) n))
 
 
;; ## EXERCISE 11.3.2. ##
;;
;; Data analysis & design
;; (define (tie-dyed n))
;; tie-dyed is a function where n is a number. It consumes an integer
;; and produces a list of that many numbers each randomly chosen
;; in the range from 20 and 120
 
 ;; Contract & Purpose:
 ;; tie-dyed : number -> list
 ;; To produce a list of numbers between 20 and 120, given a number
 ;; for number of list items.
 
 ;; Examples:
 ;; (tie-dyed 2)
 ;; expected value: 
 ;; (cons 25 (cons 110 empty))
 
 ;; Template:
;; (define (tie-dyed n)
;;   (cond
;;     [(<= n 0) ...]
;;     [else ....]))
 
 ;; Definition:
(define (tie-dyed n)
  (cond
    [(<= n 0) empty]
    [else 
     (cons (random-n-m 20 120) (tie-dyed (sub1 n)))]))

;; Tests:
;; see example


;; ## EXERCISE 11.3.3. ##
;;
;; Data analysis & design
;; (define (create-temps n low high) 
;; create-temps is a function where n, low and high are integers
;; It produces a list consisting of n items with temperature entries
;; between low and high

;; Contract & purpose
;; create-temps: number number number -> list
;; to create a list of temperatures with definite amount of items
;; and values which vary between some min and max values.

;; SERIOUSLY!???!?! tuning up previous exercise, and we're done.
(define (create-temps n min max)
  (cond
    [(<= n 0) empty]
    [else 
     (cons (random-n-m min max) (create-temps (sub1 n) min max))]))
;; Ta-da!


;; ----------------------------
;; ## EXERCISE 11.3.4. ##
;; Oh, come on! Exactly the same thing!
;; create-prices : n -> list
;; (Creates prices between .10$ and 10$)

(define (create-prices n)
  (cond
    [(<= n 0) empty]
    [else 
     (cons (* (random-n-m 1 100) 0.1) (create-prices (sub1 n)))]))

;; Ta-da! Cba to integrate it with previous exercises (9.5.3)



;; ----------------------------
;; ## EXERCISE 11.3.5. ##
;; Now we're talking! Something creative!
;;
;; Just took a peek into another ones code, lesson learned:
;; Use in-built function (check-expect test expected) to test f-ns
;; 

;; Auxiliary variables:
(define canvasWidth 300)  
(define canvasHeight 300)  
(define rowCount 5)
(define colCount 5)
(define baloonSize 5)

;; Auxiliary functions:

;; draw-rows : rowCount canvasHeight -> true
(define (drawRows rowCount canvasHeight canvasWidth)
  (cond
    [(zero? rowCount) true]
    [else (and
           (draw-solid-line (make-posn 0 canvasHeight ) 
                            (make-posn canvasWidth canvasHeight))
           (drawRows (sub1 rowCount) 
                      (- canvasHeight (/ canvasHeight rowCount))
                      canvasWidth))]))

;; draw-cols : colCount canvasWidth -> true
(define (drawCols colCount canvasHeight canvasWidth)
  (cond
    [(zero? colCount) true]
    [else (and
           (draw-solid-line (make-posn canvasWidth 0 ) 
                            (make-posn canvasWidth canvasHeight))
           (drawCols (sub1 colCount)
                      canvasHeight
                      (- canvasWidth (/ canvasWidth colCount))
                     ))]))

;; random-n-m : n m -> number
;; (defined before already)
;;
;; Data analysis & design
;; (define (student-riot n)...)
;; student-riot is a function where n is a natural number
;; which represents the number of baloons thrown
;; // Assume typical riot uses 'red only as color

;; Contract & purpose
;; student-riot : n -> true
;; to draw random dots on a grid representing thrown
;; balloons filled with color by student riot. the number of dots
;; is represented by number n

;; Template:
;;(define (student-riot n)
;;  (cond
;;    [(zero? n) ...]
;;    [else ... ]))

;; Definition:
(define (student-riot n)
  (cond
    [(zero? n) true]
    [else 
     (and
      (draw-solid-disk
       (make-posn
        (random-n-m 1 canvasWidth)
        (random-n-m 1 canvasHeight)) baloonSize 'red)
      (student-riot (sub1 n)))]))
      
;; Tests:
;(start canvasWidth canvasHeight)
;(drawCols colCount canvasHeight canvasWidth)
;(drawRows rowCount canvasHeight canvasWidth)
;(student-riot 25)
;; expected output: random distribution of dots among the grid
;; works flawlessly



;; ----------------------------
;; ## EXERCISE 11.4.1. ##

;; factorial! nice!
;; ! : N -> N
;; to compute n * (n -1) .... * 2 * 1
(define (! n)
  (cond
    [(zero? n) 1]
    [else (* n (! 
                (cond
                  [(> 0 n) (add1 n)]
                  [else (sub1 n)])))]))
;(check-expect (! 7) 5040)


;; ## EXERCISE 11.4.2. ##

;; A natural number [>= 20] is either:
;;   1. 20 or
;;   2. (add1 n) if n is a natural number [>= 20].

;; product-from-20 : N [>= 20] -> N
;; to compute n * (n - 1) * ... * 21 * 1
(define (product-from-20 n-above-20) 
  (cond
    [(zero? n-above-20) 1]
    [else (/ (! n-above-20) (! 20))]))

;(check-expect (product-from-20 22) 462)

;; product-from-minus-11 : N [>= -11] -> N
(define (product-from-minus-11 n-above-minus-11) 
  (cond
    [(zero? n-above-minus-11) 1]
    [else (/ (! n-above-minus-11) (! -11))]))

;(check-expect (n-above-minus-11 -12) -12)

;; general product function
;; product : N [limit] N[>= limit] -> N
;; to compute n * (n - 1) * .... * (limit + 1) * 1
(define (product limit n)
  (cond
    [(= n limit) 1]
    [else (* n (product limit (sub1 n)))]))

;; Let limit be a natural number. A natural number [>= limit] (N[>=limit]) is either:
;;  1. limit or
;;  2. (add1 n) if n is a natural number [>= limit].

;;
;; ------------------------
;; ## EXERCISE 11.4.5. ##

;; tabulate-f-lim : n[>= limit] n[limit] -> list
;; to tabluate the values of f from some natural number
;; n down to some natural number limit
;; natural number here > 0
(define (tabulate-f-lim n limit) 
  (cond
    [(< n limit) empty]
    [else (cons (make-posn n (f n)) (tabulate-f-lim (sub1 n) limit))]))
;;
;; ------------------------
;; ## EXERCISE 11.4.6. ##
;; tabulate-f-up-to-20 : N [<= 20] -> list
(define (tabulate-f-up-to-20 n-below-20)
  (cond
    [(> n-below-20 20) empty]
    [else (cons (make-posn n-below-20 (f n-below-20)) 
                (tabulate-f-up-to-20 (add1 n-below-20)))]))
;;
;; ------------------------
;; ## EXERCISE 11.4.7. ##
;; is-not-divisible-by<=i 
;; consumes a natural number [>= 1], i and a naturan number m with i < m
;; if m is not divisible by any number between 1(exclusive) and i (inclusive),
;; the function produces true, otherwise the output is false
(define (is-not-divisible-by<= i m)
  (cond
    [(<= i 1) true]
    [else 
     (and
       (> (remainder m i) 0)
       (is-not-divisible-by<= (sub1 i) m))]))
    
;; prime? : n [>0] -> boolean
(define (prime? n)
  (is-not-divisible-by<= (sub1 n) n))

;(check-expect (prime? 43) true)
;(check-expect (prime? 69) false)
;(check-expect (prime? 63) false)
;(check-expect (prime? 73) true)


;; ------------------------
;; ## EXERCISE 11.5 ##

;; add-to-pi : N -> number
;; to compute n + 3.14 without using +
;; (define (add-to-pi n) ...)

;; Examples:
;; (add-to-pi 0) =  3.14
;; (add-to-pi 2) = 5.14
;; (add-to-pi 6) = 9.14

;;
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]))

;; ------------------------
;; ## EXERCISE 11.5.1. ##
;; add : n x -> n + x without using +
(define (add n x)
  (cond 
    [(zero? x) n]
    [else (add1 (add n (sub1 x)))]))

;(check-expect (add 4 6) 10)
;(add 4 6)
;; function will descend X levels down, and each time it is told to add1 on each level
;; to the lowest number it bottoms out at and by making sure that number is
;; n, we can add x to n without using scheme's +

;; ------------------------
;; ## EXERCISE 11.5.2. ##
;; multiply-by-pi : n -> n
;; consumes a natural number and multiplies it with 3.14 wihtout using *
;; ex:
;; (multiply-by-pi 0) = 0
;; (multiply-by-pi 2) = 6.28
(define (multiply-by-pi n)
  (cond
    [(zero? n) 0]
    [else (+ 3.14 (multiply-by-pi (sub1 n)))]))
;;
;; multiply : n -> n 
;; to multiply 2 numbers without using + or *
(define (multiply n m)
  (cond
    [(zero? n) 0]
    [(zero? m) 0]
    [(= n 1) m]
    [(= m 1) n]
    [else (add n (multiply n (sub1 m)))]))

;(multiply 1 6)


;; ------------------------
;; ## EXERCISE 11.5.3. ##

;; exponent : n x -> n^x
(define (exponent n x)
  (cond
    [(zero? x) 1]
    [(= x 1) n]
    [else (multiply n (exponent n 
                                (cond      
                                  [(> x 0) (sub1 x)]
                                  [else (add1 x)])))]))
;(check-expect (exponent 15 2) 225)




;; ------------------------
;; ## EXERCISE 11.5.4. ##
;; addDL : list1 list2 -> list3
;; addDL is a function which consumes 2 deep lists
;; representing natural numbers n and m and produces a deep list 
;; representing n + m

;; I'm not quite sure I get this...
(define list11 (cons 'list1 (cons 'list1 empty)))
(define list22 (cons 'list2 (cons 'list2 (cons 'list2 empty))))

;; addDL : list1 list2 -> list3
(define (addDL list11 list22)
 (make-deep 'list33 (+ (depth list11) (depth list22))))

;(check-expect (depth (addDL list11 list22)) 5)



