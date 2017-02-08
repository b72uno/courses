;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |21|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;;  ---------------------------
;;          Section 21
;;Designing abstractions from examples
;;  Abstracting from examples
;; -----------------------------

(define (map1 f lon)
  (cond
    [(empty? lon) empty]
    [else (cons (f (first lon)) (map1 (rest lon)))]))

;; There usually are some more or less defined
;; steps whenever you are abstracting something
;; - The Comparison
;; - The Abstraction
;; - The Test
;; - The Contract
;;

;; -------------------------
;;    Exercise 21.1.1.
;; -------------------------
;; Define 'tabulate' which is the abstraction of following 2 functions:
;; tabulate-sin : number -> lon
;; to tabulate sin between n and 0 (inclusive) in a list
(define (tabulate-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else 
      (cons (sin n)
            (tabulate-sin (sub1 n)))]))

;; tabulate-sqrt : number -> lon
;; to tabulate sqrt between n and 0 (inclusive) in a list
(define (tabulate-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
      (cons (sqrt n)
            (tabulate-sin (sub1 n)))]))

;; Also use tabulate to define a tabulation  function for sqr and tan.
;; What would be a good, general contract?

;; tabulate : (number -> number) number -> (listof number)
;; and maybe more general contract:
;; tabulate : (X -> Y) number -> (listof Y)
(define (tabulate f n)
  (cond
    [(= n 0) (list (f 0))]
    [else (cons (f n)
                (tabulate f (sub1 n)))]))

;(check-expect (tabulate-sin 8) (tabulate sin 8))
; (check-expect (tabulate-sqrt 8) (tabulate sqrt 8)) ;; Floating point issues ofc, it is equal
; for sqr and tan we can use sqr and tan respectively


;; -------------------------
;;    Exercise 21.1.2.
;; -------------------------
;; Define 'fold' which is the abstraction of the following 2 functions
;; sum : (listof number) -> number
;; to compute the sum of the numbers on alon
(define (sum alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon) (sum (rest alon)))]))

;; product : (listof number) -> number
;; to compute the product of all numbers on alon
(define (product alon)
  (cond
    [(empty? alon) 1]
    [else (* (first alon) (product (rest alon)))]))


;; fold : f (listof number) X -> number
;; more general would be something like tabulate above
;; X is anything that gets done when the list is empty
(define (fold f alon basacase)
  (cond
    [(empty? alon) basacase]
    [else (f (first alon) (fold f (rest alon) basacase))]))

; (check-expect (sum (list 1 2 3 4 5)) (fold + (list 1 2 3 4 5) 0))
; (check-expect (product (list 1 2 3 4 5)) (fold * (list 1 2 3 4 5) 1))

;; After defining fold, use it to define append, which juxtaposes the items
;; of two lists or, equivalently, replaces empty at the end of the first list 
;; with the second list.

;; append : (listof X) (listof X) -> (listof X)
(define (append1 list1 list2)
  (fold cons list1 list2))

; (check-expect (append1 (list 1 2 3) (list 4 5 6)) (append (list 1 2 3) (list 4 5 6)))

;; finally, define map using fold
(define (map2 f list1)
    (cond
      [(empty? list1) empty]
      [else (append (fold cons (list (f (first list1))) empty) (map2 f (rest list1)))]))
;; to be honest, I have no idea how to do this. Will find out from someone
;; who has already done this.
;(check-expect (map2 sqr (list 1 2 3 4 5)) (map sqr (list 1 2 3 4 5)))

;; mkei here's what suguni did, pretty neat!:
(define (map3 f list1)
  (cond
    [(empty? list1) empty]
    [else
     (fold cons (list (f (first list1)))
     (map3 f (rest list1)))]))
;(check-expect (map3 sqr (list 1 2 3 4 5)) (map sqr (list 1 2 3 4 5)))


;; Define a general contract [for fold I guess??]
;; fold : (X -> Y) (listof X) -> Y-ish sth :D
    
;; -------------------------
;;    Exercise 21.1.3.
;; -------------------------
;; Define function natural-f, which is abstraction of the following 2 functions:

;; copy : N X -> (listof X)
;; to create a list that contains
;; object X N times
(define (copy n obj)
  (cond
    [(zero? n) empty]
    [else (cons obj (copy (sub1 n) obj))]))

;;n-adder : N number ->
;;to add n to x using only
;;(+ 1 ...) 
(define (n-adder n x)
  (cond
    [(zero? n) x]
    [else (+ 1 (n-adder (sub1 n) x))]))


;; natural-f : function counter obj basacase -> obj/(listof obj)
(define (natural-f f counter obj basacase)
  (cond
    [(zero? counter) basacase]
    [else (f obj (natural-f f (sub1 counter) obj basacase))]))

;(check-expect (copy 3 'lo) (natural-f cons 3 'lo empty))
;(check-expect (n-adder 6 4) (natural-f + 4 1 6))

;; No idea how to make a n-addder using natural-f.
;; EDIT: Turns out all I had to do was to swap variables, i.e.
;; using one number for base case and other for counter and
;; add 1 all the time. I had not defined explicitly functions
;; n-adder and copy using natural-f, perhaps that would have helped.

;; Also use natural-f to define n-multiplier, which consumes n and x and produces
;; »n times x with additions only. Use the example to formulate a contract. 

(define (n-multiplier n x)
  (natural-f + n x 0))

;; general contract for natural-f
;; natural-f : (X->Y) number X Z -> sth Yish
;; first is function which acts upon x, turns it into y
;; number is a counter for looping
;; Z is a base case for when the function bottoms out

;;----------------------------------------------------
;; 21.2 Finger exercises with abstract list functions
;;----------------------------------------------------

;; ( build-list ; filter ; quicksort ; map ;
;; andmap ; ormap ; foldr ; foldl ; assf; )

;; build-list : N (N->X) -> (listof X)
;; to construct (list (f 0) ... (f (- n 1))
;; (define (build-list n f) ...)

;; filter : (X->boolean) (listof X) -> (listof X)
;; to construct a list from all those items on alox for which p holds
;; (define (filter p alox) ...)

;; quicksort : (listof X) (X X -> boolean) -> (listof X)
;; to construct a list from all items on alox in an order according to cmp
;; (define (quicksort alox cmp) ...)

;; map : (X->Y) (listof X) -> (listof Y)
;; to construct a list by applying f to each item on alox
;; (define (map f alox) ...)

;; andmap : (X->boolean) (listof X) -> boolean
;; to determine whether p holds for every item on alox
;; (define (andmap p alox) ...)

;; ormap : (X-> boolean) (listofX) -> boolean
;; to determine whether p holds for at least one item on alox
;; (define (ormap p alox) ...)

;; foldr : (X Y -> Y) Y (listof X) -> Y
;; (foldr f base (list x-1 ... x-n)) = (f x-1 ... (f x-n base))
;; (define (foldr f base alox) ...)

;; foldl : (X Y -> Y) Y (listof X) -> Y
;; (foldl f base (list x-1 ... x-n)) = (f x-n ... (f x-1 base))

;; assf : (X->boolean) (listof (list X Y)) -> (listof X Y) or false
;; to find the first item on alop for whose the first item p? holds
;; (define (assf p? alop) ....)


;; -------------------------
;;    Exercise 21.2.1.
;; -------------------------

;; Use build-list

;; to create lists 0 ... 3 and 1 ... 4 and (list .1 .01 .001 .0001)
;(check-expect (build-list 4 +) (list 0 1 2 3))
;(check-expect (build-list 4 add1) (list 1 2 3 4))
(define (aux1 x) (/ (/ (add1 x) (add1 x)) (expt 10 (add1 x))))
;(check-expect (build-list 4 aux1) (list .1 .01 .001 .0001))

;; to define evens which consumes a natural number n acreates the list
;; of the first n even numbers
;; evens : number -> (listof number)
(define (evens n) (local((define (evensaux n) (* (add1 n) 2)))
                    (build-list n evensaux)))
;(check-expect (evens 10) (list 2 4 6 8 10 12 14 16 18 20))
  
;; to define tabulate from exercise 21.1.1.
;; tabulate : (number->number) number -> (listof number)
(define (bltabulate f n) (reverse (build-list (add1 n) f)))
;(check-expect (bltabulate add1 5) (tabulate add1 5))
;(check-expect (bltabulate sqr 5) (tabulate sqr 5))


;; to define diagonal which consumes natural number n and creates 
;; a list of lists of 0 and 1, the number represents # of rows.
;; think - identity matrix.
;; diagonal : number -> (listof (listof numbers))
;; TAKING THIS FROM SUGUNI, FUCK THIS, CANT FIGURE IT OUT
(define (diagonal n)
  (local
     ((define (row c r)
        (cond
          [(= c n) empty]
          [else
           (cond
             [(= c r) (cons 1 (row (add1 c) r))]
             [else (cons 0 (row (add1 c) r))])]))
      (define (mat r)
        (row 0 r)))
    (build-list n mat)))

;; test:
;(check-expect (diagonal 3) (list (list 1 0 0) 
;                                 (list 0 1 0) 
;                                 (list 0 0 1)))


;; -------------------------
;;    Exercise 21.2.2.
;; -------------------------

;; Use map to define the following functions:

;; 1. convert -euro which converts a list of US dollar amounts into 
;; a list of euro amounts based on exchange rate of 1.22 euro for each dollar
;; convert-euro : (listof X) -> (listof Y)
(define (convert-euro lox)
  (local ((define (converteur x)
            (/ x 1.22)))
    (map converteur lox)))

;; 2. convertFC, which converts a list of fahrenheit measurements to
;; Celsius measurements.
(define (convertFC lox)
  (local ((define (fromFtoC x)
            (* (- x 32) (/ 5 9))))
    (map fromFtoC lox)))

;; 3. move-all, which consumes a list of posn structures and translates
;; each by adding 3 to the x component.
(define (move-all los)
  (local ((define (moveby3 shape)
            (make-posn (+ (posn-x shape) 3) (posn-y shape))))
    (map moveby3 los)))

;; -------------------------
;;    Exercise 21.2.3.
;; -------------------------

;; version of filter that DrScheme provides:
;; filter : ( X -> boolean) (listof X) -> (listof X)
;; to construct a list of X from all those items on alon
;; for which predicate holds
(define (filter2 predicate? alon)
  (cond
    [(empty? alon) empty]
    [else (cond
            [(predicate? (first alon))
             (cons (first alon) (filter predicate? (rest alon)))]
            [else (filter predicate? (rest alon))])]))

;; Use filter to define following functions:
;; 1. eliminate-exp which consumes a number ua, and a list of toy
;; structures (containing name and price) and produces a list of all of those
;; descriptions whose price is below ua. wat descriptions???
;; eliminate-exp : number (listof X) -> (listof X)
(define-struct toy (name price)) 
(define (eliminate-exp maxprice listoftoys)
  (local ((define (tooexp toy)
            (< (toy-price toy) maxprice)))
          (filter tooexp listoftoys)))
(check-expect (eliminate-exp 5.0 (list (make-toy 'Batmobile 4.0) (make-toy 'Batcave 8.0) (make-toy 'Batman 2.0)))
              (list (make-toy 'Batmobile 4.0) (make-toy 'Batman 2.0)))

;; 2. recall, which consumes the name of a toy, called ty, and a list
;; of names, called lon, and produces a list of names that contains all
;; components of lon with the exception of ty.
;; recall : symbol (listof X) -> (listof X)
(define (recall ty lon)
  (local ((define (hastyname toy)
            (equal? (toy-name toy) ty)))
    (filter hastyname lon)))

(check-expect (recall 'Batman (list (make-toy 'Batmobile 4.0) (make-toy 'Batcave 8.0) (make-toy 'Batman 2.0)))
              (list(make-toy 'Batman 2.0)))
                                
;; 3. selection, which consumes two lists of names and selects all those from the second
;; one that are also on the first.
;; selection : (listof X) (listof X) -> (listof X)
(define (selection lon1 lon2)
  (local
    ((define (isinlist name lon)
       (cond
         [(empty? lon) false]
         [else (or (equal? name (first lon)) (isinlist name (rest lon)))]))
     (define (isinlistyo name)
       (isinlist name lon1)))      
     (filter isinlistyo lon2)))

(check-expect (selection
               (list 'Joe 'Zoey 'Sarah 'Christin 'Yin)
               (list 'Jim 'Samantha 'Danny 'Kim 'Bob 'Sarah 'Zoey))
              (list 'Sarah 'Zoey))


;; 21.3 Abstraction and a Single Point of Control

;; Guidline on creating abstractions:
;; FORM AN ABSTRACTION INSTEAD OF COPYING AND MODIFYING
;; A PIECE OF PROGRAM!

;; Maintaining software is expensive!
;; You can reduce the maintenance cost by organizing programs
;; correctly. Match the functions structure to the structure of
;; its input data! Introduce proper abstractions!


;; -----------------------------
;;    Extended Exercise 21.4
;; -----------------------------

;; Moving Pictures, Again!

;; FU@K THIS SH!T!
;; I'm sick of those pictures, here's suguni's code. kthxbye

;; ex 21.4.1
;; Shape definitions from ex 7.4.1
;; Data Definitions:
(define-struct circle (center radius color))
;; A circle is a structure:
;;          (make-circle p s c)
;;    where p is a posn, s is a number and c is a color;

;; process-circle
;; abstract draw-circle/clear-circle
(define (process-circle fn c)
  (fn (circle-center c)
      (circle-radius c)
      (circle-color c)))

;; draw-a-circle : circle -> true
;; draw a circle s
(define (draw-a-circle c)
  (process-circle draw-circle c))

;; clear-a-circle : circle -> true
;; clear a circle s
(define (clear-a-circle c)
  (process-circle clear-circle c))

;; translate-circle : circle, number -> circle
;; 보조함수를 define으로 정의하라고 했다. d(이동거리) 인자가 필요하므로 local로 정의함.
;(define (translate-circle s d)
;  (local ((define (translate p r c)
;            (make-circle
;             (make-posn (+ d (posn-x p)) (posn-y p))
;             r c)))
;    (process-circle translate s)))

;; tests
;(check-expect (translate-circle (make-circle (make-posn 0 0) 10 'red) 10)
;              (make-circle (make-posn 10 0) 10 'red))

;; ex 21.4.2
(define-struct rectangle (nw width height color))
;; A rectangle is a structure:
;;          (make-rectangle p w h c)
;;    where p is a posn, w and h a number and c is a color.

;; process-rectagnle : [posn number number color -> X] rectagle -> X
(define (process-rectangle fn a-rect)
  (fn (rectangle-nw a-rect)
      (rectangle-width a-rect)
      (rectangle-height a-rect)
      (rectangle-color a-rect)))

;; draw-a-rectangle : rectangle -> true
;; draw a rectangle s
(define (draw-a-rectangle a-rect)
  (process-rectangle draw-solid-rect a-rect))

;; clear-a-rectangle : rectangle -> true
;; clear a rectangle s
(define (clear-a-rectangle a-rect)
  (process-rectangle clear-solid-rect a-rect))

;; translate-rectangle : rectangle, number -> rectangle
;(define (translate-rectangle a-rect delta)
;  (local ((define (translate a-posn width height color)
;            (make-rectangle
;             (make-posn (+ delta (posn-x a-posn))
;                        (posn-y a-posn))
;             width height color)))
;    (process-rectangle translate a-rect)))

;; tests
;(check-expect (translate-rectangle (make-rectangle (make-posn 0 0) 10 20 'red) 10)
;              (make-rectangle (make-posn 10 0) 10 20 'red))

;; ex 21.4.3 -- ????
;; 구지 하자면 이렇게??? 암만 봐도 아닌거 같은데. - FAIL!!!

;; process-shape : (listof [shape -> X]), shape -> X
;(define (process-shape fns s)
;  (cond
;    [(circle? s) ((first fns) s)]
;    [(rectangle? s) ((second fns) s)]))

;; draw-shape : shape -> true
;; draw a shape s
;(define (draw-shape s)
;  (process-shape (list draw-a-circle draw-a-rectangle) s))
(define (draw-shape s)
  (cond
    [(circle? s) (draw-a-circle s)]
    [(rectangle? s) (draw-a-rectangle s)]
    [(line? s) (draw-a-line s)]))

;; clear-shape : shape -> true
;; clear a shape s
;(define (clear-shape s)
;  (process-shape (list clear-a-circle clear-a-rectangle) s))
(define (clear-shape s)
  (cond
    [(circle? s) (clear-a-circle s)]
    [(rectangle? s) (clear-a-rectangle s)]
    [(line? s) (clear-a-line s)]))

;; fun-for-shape : a-shape -> ???
(define (fun-for-shape a-shape)
  (cond
    [(circle? a-shape) ...]
    [(rectangle? a-shape) ...]))

;; translate-shape : shape, number -> shape
;(define (translate-shape a-shape delta)
;  (local ((define (t1 s) (translate-circle s delta))
;          (define (t2 s) (translate-rectangle s delta)))
;    (process-shape (list t1 t2) a-shape)))
;(define (translate-shape a-shape delta)
;  (cond
;    [(circle? a-shape) (translate-circle a-shape delta)]
;    [(rectangle? a-shape) (translate-rectangle a-shape delta)]))

;; ex 21.4.4
;; draw-losh : shapes -> true
(define (draw-losh losh)
  (andmap draw-shape losh))

;; clear-losh : shapes -> true
(define (clear-losh losh)
  (andmap clear-shape losh))

;; translate-losh : shapes number -> shapes
(define (translate-losh losh dx dy)
  (local ((define (translate s)
            (translate-shape s dx dy)))
    (map translate losh)))

;; ex 21.4.5
;; translate-circle : circle, number, number -> circle
(define (translate-circle s dx dy)
  (local ((define (translate p r c)
            (make-circle
             (make-posn (+ dx (posn-x p))
                        (+ dy (posn-y p)))
             r c)))
    (process-circle translate s)))

;; tests
(check-expect (translate-circle (make-circle (make-posn 0 0) 10 'red) 10 5)
              (make-circle (make-posn 10 5) 10 'red))

;; translate-rectangle : rectangle, number, number -> rectangle
(define (translate-rectangle a-rect dx dy)
  (local ((define (translate a-posn width height color)
            (make-rectangle
             (make-posn (+ dx (posn-x a-posn))
                        (+ dy (posn-y a-posn)))
             width height color)))
    (process-rectangle translate a-rect)))

;; tests
(check-expect (translate-rectangle (make-rectangle (make-posn 0 0) 10 20 'red) 10 5)
              (make-rectangle (make-posn 10 5) 10 20 'red))

;; translate-shape : shape, number, number -> shape
;(define (translate-shape a-shape dx dy)
;  (local ((define (t1 s) (translate-circle s dx dy))
;          (define (t2 s) (translate-rectangle s dx dy)))
;    (process-shape (list t1 t2) a-shape)))
(define (translate-shape a-shape dx dy)
  (cond
    [(circle? a-shape) (translate-circle a-shape dx dy)]
    [(rectangle? a-shape) (translate-rectangle a-shape dx dy)]
    [(line? a-shape) (translate-line a-shape dx dy)]))

;; tests
;(check-expect (translate-shape (make-circle (make-posn 0 0) 10 'red) 10 5)
;              (make-circle (make-posn 10 5) 10 'red))
;(check-expect (translate-shape (make-rectangle (make-posn 0 0) 10 20 'red) 10 5)
;              (make-rectangle (make-posn 10 5) 10 20 'red))
;(check-expect (translate-shape (make-line (make-posn 0 0) (make-posn 10 10) 'red) 8 5)
;              (make-line (make-posn 8 5) (make-posn 18 15) 'red))

;; line
(define-struct line (start end color))
;; A rectangle is a structure:
;;          (make-line s e c)
;;    where s and e are posns, and c is a color.

;; process-line : [posn posn color -> X] line -> X
(define (process-line fn a-line)
  (fn (line-start a-line)
      (line-end a-line)
      (line-color a-line)))

;; draw-a-line : line -> true
;; draw a line a-line
(define (draw-a-line a-line)
  (process-line draw-solid-line a-line))

;; clear-a-line : line -> true
;; clear a line a-line
(define (clear-a-line a-line)
  (process-rectangle clear-solid-line a-line))

;; translate-line : line, number, number -> line
(define (translate-line a-line dx dy)
  (local ((define (translate start end color)
            (make-line
             (make-posn (+ dx (posn-x start))
                        (+ dy (posn-y start)))
             (make-posn (+ dx (posn-x end))
                        (+ dy (posn-y end)))
             color)))
    (process-line translate a-line)))

;; tests
(check-expect (translate-line (make-line (make-posn 0 0) (make-posn 10 10) 'red) 8 5)
              (make-line (make-posn 8 5) (make-posn 18 15) 'red))

(define LUNAR (list
               (make-circle (make-posn 10 10) 10 'blue)
               (make-rectangle (make-posn 0 20) 20 10 'red)
               (make-line (make-posn 6 30) (make-posn 0 40) 'black)
               (make-line (make-posn 14 30) (make-posn 20 40) 'black)
               ))

(define (lunar-lander dy lunar)
  (draw-losh
   (translate-losh lunar 0 dy)))

;; ????
;(start 500 100)
;(draw-losh LUNAR)
;(control-up-down LUNAR 10 lunar-lander draw-losh)


;; 21.5. Note: Designing Abstractions from Templates


