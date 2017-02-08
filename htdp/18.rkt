;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |18|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; -------------------------
;;        Section 18
;;  Local Definitions and
;;       Lexical Scope
;; -------------------------

;; local - a simple construct for organizing
;; collections of functions.

;; concept of variable binding

;; <exp> = (local (<def-1>...<def-n>)<exp>)
;; (<def...<def-n>) part is called LOCAL DEFINITION
;; definitions are called the LOCALLY DEFINED
;; All those in the definition window are TOP-LEVEL DEFINITIONS
;; The xpression in each definition is called RIGHT-HAND SIDE expression
;; The expression that follows the definitions is the BODY

;; example:
;(local ((define (f x) (+ x 5))
;        (define (g alon)
;          (cond
;            [(empty? alon) empty]
;            [else (cons (f (first alon)) (g (rest alon)))])))
;  (g (list 1 2 3)))

;; The locally defined functions are f and g. The right hand side of the first def
;; is (+ x 5), the second one is ... <too long to write down> ..
;; Finally, the body of the local-expression is (g (list 1 2 3))


;; -------------------------
;;    Exercise 18.1.1
;; -------------------------

;; Find parts:

;1. (local ((define x <local definition->)(* y 3)))
;       <the-body->(* x x))
;
;2. (local ((define (odd an)
;	       <local-def->(cond
;		 [(zero? an) false]
;		 [else (even (sub1 an))]))
;	     (define (even an)
;	      <local-def-> (cond
;		 [(zero? an) true]
;		 [else (odd (sub1 an))])))
;       <the-body->(even a-nat-num))
;
;3. (local ((define (f x) <local-def->(g x (+ x 1)))
;	     (define (g x y) <local-def->(f (+ x y))))
;       <the-body->(+ (f 10) (g 10 20)))


;; -------------------------
;;    Exercise 18.1.2
;; -------------------------

;; Why those are not syntactically legal? 

;1. (local ((define x 10)
;	     (y (+ x x)))
;       y)
; because there is no variable y defined. It should be (define y (+ x x))
;
;2. (local ((define (f x) (+ (* x x) (* 3 x) 15))
;	     (define x 100)
;	     (define f@100 (f x)))
;       f@100 x)
; because the body translates to (f x) 100 which is not quite right, its an extra part there.
;
;3. (local ((define (f x) (+ (* x x) (* 3 x) 14))
;	     (define x 100)
;	     (define f (f x)))
;       f)
; circular reference? it would be (f (f (f (f (f (f ... up to infinity 100 ))))))... up to infinity


;; -------------------------
;;    Exercise 18.1.3
;; -------------------------

;; Which are legal and which are not? Why?

;1. (define A-CONSTANT
;       (not 
;	 (local ((define (odd an)
;		   (cond
;		     [(= an 0) false]
;		     [else (even (- an 1))]))
;		 (define (even an)
;		   (cond
;		     [(= an 0) true]
;		     [else (odd (- an 1))])))
;	   (even a-nat-num))))
; a-nat-num is not defined, otherwise it is legal

;2. (+ (local ((define (f x) (+ (* x x) (* 3 x) 15))
;		(define x 100)
;		(define f@100 (f x)))
;	  f@100)
;	1000)
; seems legit
;3. (local ((define CONST 100)
;	     (define f x (+ x CONST)))
;       (define (g x y z) (f (+ x (* y z)))))
;; ;; illegal, extra part at define f x ...



;; SEMANTICS OF LOCAL

;; The purpose of a local expression is to define a variable, a function, or a structure
;; for the evaluation of the body expression. Outside of the local-expression definitions
;; have no effect.
;; ex.: (local ((define pi 3)) (+ 2 pi)) vs (+ 2 pi) = 5 vs 5.141592...



;; -------------------------
;;    Exercise 18.1.4.
;; -------------------------

;Since local definitions are added to the Definitions window during
;an evaluation, we might wish to try to see their values by just 
;typing in the variables into the Interactions window. 
;Is this possible? Why or why not?

; I have no idea.



;; -------------------------
;;    Exercise 18.1.5.
;; -------------------------

;; Evaluate by hand:

;1. (local ((define (x y) (* 3 y)))
;       (* (x 2) 5))
;  (local ((define (x y) (* 3 y)))
;       (* (* 3 2) 5))
;  (local ((define (x y) (* 3 y)))
;       (* 6 5))
;  (local ((define (x y) (* 3 y)))
;       30)
; 30


;2. (local ((define (f c) (+ (* 9/5 c) 32)))
;       (- (f 0) (f 10)))
; (local ((define (f c) (+ (* 9/5 c) 32)))
;       (- (+ (* 9/5 0) 32)) (+ (* 9/5 10) 32))))
; (local ((define (f c) (+ (* 9/5 c) 32)))
;       (- 32 50))
; (local ((define (f c) (+ (* 9/5 c) 32)))
;       -18 )
; -18


;
;3. (local ((define (odd? n)
;	       (cond
;		 [(zero? n) false]
;		 [else (even? (sub1 n))]))
;	     (define (even? n)
;	       (cond
;		 [(zero? n) true]
;		 [else (odd? (sub1 n))])))
;       (even? 1))
;(local ((define (odd? n)
;	       (cond
;		 [(zero? n) false]
;		 [else (even? (sub1 n))]))
;	     (define (even? n)
;	       (cond
;		 [(zero? n) true]
;		 [else (odd? (sub1 n))])))
;       ((cond
;		 [(zero? 1) true]
;		 [else (odd? (sub1 1))])))
;(local ((define (odd? n)
;	       (cond
;		 [(zero? n) false]
;		 [else (even? (sub1 n))]))
;	     (define (even? n)
;	       (cond
;		 [(zero? n) true]
;		 [else (odd? (sub1 n))])))
;       ((cond
;		 [false true]
;		 [else (odd? (sub1 1))])))
;(local ((define (odd? n)
;	       (cond
;		 [(zero? n) false]
;		 [else (even? (sub1 n))]))
;	     (define (even? n)
;	       (cond
;		 [(zero? n) true]
;		 [else (odd? (sub1 1))])))
;       ((cond
;		 [false true]
;		 [else (odd? 0)])))
;(local ((define (odd? n)
;	       (cond
;		 [(zero? n) false]
;		 [else (even? (sub1 n))]))
;	     (define (even? n)
;	       (cond
;		 [(zero? n) true]
;		 [else (odd? (sub1 1))])))
;       ((cond
;		 [false true]
;		 [else (cond
;		 [(zero? 0) false]
;		 [else (even? (sub1 0))])])))
;(local ((define (odd? n)
;	       (cond
;		 [(zero? n) false]
;		 [else (even? (sub1 n))]))
;	     (define (even? n)
;	       (cond
;		 [(zero? n) true]
;		 [else (odd? (sub1 1))])))
;       ((cond
;		 [false true]
;		 [else (cond
;		 [true false]
;		 [else (even? (sub1 0))])])))
; false


;
;4. (+ (local ((define (f x) (g (+ x 1) 22))
;		(define (g x y) (+ x y)))
;	  (f 10))
;	555)
; (+ (local ((define (f x) (g (+ x 1) 22))
;		(define (g x y) (+ x y)))
;	  (g (+ 10 1) 22))
;	555)
; (+ (local ((define (f x) (g (+ x 1) 22))
;		(define (g x y) (+ x y)))
;	  (g 11 22))
;	555)
; (+ (local ((define (f x) (g (+ x 1) 22))
;		(define (g x y) (+ x y)))
;	  (+ 11 22))
;	555)
; (+ (local ((define (f x) (g (+ x 1) 22))
;		(define (g x y) (+ x y)))
;	  33)
;	555)
; (+ 33 555)
;; 588



;5. (define (h n) 
;       (cond
;	 [(= n 0) empty]
;	 [else (local ((define r (* n n)))
;		 (cons r (h (- n 1))))]))
;     (h 2)
;(define (h n) 
;       (cond
;	 [(= n 0) empty]
;	 [else (local ((define r (* n n)))
;		 (cons r (h (- n 1))))]))
;     (cond
;	 [(= 2 0) empty]
;	 [else (local ((define r (* 2 2)))
;		 (cons r (h (- 2 1))))])
;;(define (h n) 
;       (cond
;	 [(= n 0) empty]
;	 [else (local ((define r (* n n)))
;		 (cons r (h (- n 1))))]))
;     (cond
;	 [false empty]
;	 [else (local ((define r (* 2 2)))
;		 (cons r (h 1)))])
;;;(define (h n) 
;       (cond
;	 [(= n 0) empty]
;	 [else (local ((define r (* n n)))
;		 (cons r (h (- n 1))))]))
;     (cond
;	 [false empty]
;	 [else (local ((define r (* 2 2)))
;		 (cons r (cond
;	 [(= 1 0) empty]
;	 [else (local ((define r (* 1 1)))
;		 (cons r (h (- 1 1))))]))))])
;(define (h n) 
;       (cond
;	 [(= n 0) empty]
;	 [else (local ((define r (* n n)))
;		 (cons r (h (- n 1))))]))
;     (cond
;	 [false empty]
;	 [else (local ((define r (* 2 2)))
;		 (cons 1 (cond
;	 [(= 1 0) empty]
;	 [else (local ((define r (* 1 1)))
;		 (cons r (h 0)))]))))])
; mess, cant follow this one. This thing needs color coding,
; wont do it if I cant do it properly. 
;; I see that its (cons 4 (cons 1 empty)))



;; Pragmatics of local, Part 1

; The most important use of local-expressions is to ENCAPSULATE
;; a collection of functions that serve one purpose.

;; for example our old sort function:
;; sort : alon -> alon
;; to sort a list of numbers
;(define (sort1 alon)
;  (cond
;    [(empty? alon) empty]
;    [else (insert (first alon) (sort1 (rest alon)))]))
;; insert : number alon -> alon
;; to insert a number into a sorted list
;(define (insert num alon)
;  (cond
;    [(empty? alon) (list num)]
;    [(> num (first alon)) (cons num alon)]
;    [else (cons (first alon) (insert num (rest alon)))]))

;; The first definition defines sort per se and the second one
;; defines an auxiliary function that inserts a numbers into a sorted list
;; of numbers. The first one uses the second one to construct the result
;; from a natural recursion, a sorted version of the rest of the list and
;; the first item.
;; The two functions together form the program that sorts a list of numbers.

;; To indicate this intimate relationship between the functions, we can
;; and we SHOULD use a local-expression. Specifically, we define a program
;; sort that immediately introduces the two functions as auxiliary definitions:

;; sort-desc : list-of-numbers -> sorted-list-of-numbers
;; to sort a list of numbers in descending order
(define (sort-desc alon)
  (local (
          (define (sort-desc alon)
            (cond
              [(empty? alon) empty]
              [(cons? alon) (insert (first alon)
                                    (sort-desc (rest alon)))]))
          (define (insert num alon)
            (cond
              [(empty? alon) (list num)]
              [else
               (cond
                 [(> num (first alon)) (cons num alon)]
                 [else (cons (first alon) (insert num (rest alon)))]
                 )]))
          )
    (sort-desc alon)
    )
 )

;; -------------------------
;;    Exercise 18.1.6.
;; -------------------------
;; Evaluation by hand, (sort (list 2 1 3)) and 
;; (equal? (sort (list 1)) (sort (list2)))
;; cba, I'm sick of those monotone letters already
;; I couldnt follow whats where even if I tried.
;; On the bright side next 4 exercises will make sure
;; that I learn how to use local-expressions properly.

;; -------------------------
;;    Exercise 18.1.7.
;; -------------------------
;; Use local expression to organize functions for moving
;; pictures from section 10.3.
;; I hated that exercise. Here, a soup of code:
;(define-struct circle (center radius color))
;(define-struct rectangle (xy width height color))
;          
;(define (move-picture picture delta)
;  (local (
;          
;          (define (draw-a-circle a-circle)
;            (draw-circle (make-posn (posn-x (circle-center a-circle))
;                                    (posn-y (circle-center a-circle)))
;                         (circle-radius a-circle)
;                         (circle-color a-circle)))
;          (define (draw-rectangle a-rectangle)
;            (draw-solid-rect (make-posn (posn-x (rectangle-xy a-rectangle))
;                                        (posn-y (rectangle-xy a-rectangle)))
;                             (rectangle-width a-rectangle)
;                             (rectangle-height a-rectangle)
;                             (rectangle-color a-rectangle)))
;          (define (translate-circle a-circle delta)
;            (make-circle (make-posn (+ (posn-x (circle-center a-circle)) delta)
;                                    (posn-y (circle-center a-circle)))
;                         (circle-radius a-circle)
;                         (circle-color a-circle)))
;          (define (translate-rectangle a-rectangle delta)
;            (draw-solid-rect (make-posn
;                              (+ (posn-x (rectangle-xy a-rectangle)) delta)
;                              (posn-y (rectangle-xy a-rectangle)))
;                             (rectangle-width a-rectangle)
;                             (rectangle-height a-rectangle)
;                             (rectangle-color a-rectangle)))
;          (define (clear-circle a-circle)
;            (clear-circle (circle-center a-circle)
;                          (circle-radius a-circle)
;                          (circle-color a-circle)))
;          (define (clear-a-rectangle a-rectangle)
;  (clear-solid-rect (make-posn (posn-x (rectangle-xy a-rectangle))
;                               (posn-y (rectangle-xy a-rectangle)))
;                    (rectangle-width a-rectangle)
;                    (rectangle-height a-rectangle)
;                    (rectangle-color a-rectangle)))
;          (define (draw-losh losh)
;  (cond
;    [(empty? losh) true]
;    [else (cond
;            [(circle? (first losh)) (and 
;                                     (draw-a-circle (first losh))
;                                     (draw-losh (rest losh)))]
;            [else (and
;                   (draw-rectangle (first losh))
;                   (draw-losh (rest losh)))])]))
;          (define (translate-losh losh delta)
;  (cond
;    [(empty? losh) empty]
;    [else (cond
;            [(circle? (first losh)) (cons (translate-circle (first losh) delta)
;                                          (translate-losh (rest losh) delta))]
;            [else (cons (translate-rectangle (first losh) delta)
;                        (translate-losh (rest losh) delta))])]))
;          (define (clear-losh losh)
;  (cond
;    [(empty? losh) true]
;    [else (cond
;            [(circle? (first losh)) (and
;                                     (clear-circle (first losh))
;                                     (clear-losh (rest losh)))]
;            [else (and
;                   (clear-a-rectangle (first losh))
;                   (clear-losh (rest losh)))])]))
;            (define (draw-and-clear-picture picture)
;    (and (draw-losh picture)
;    (sleep-for-a-while 1)
;    (clear-losh picture)))
;              (define (move-picture delta picture)
;    (cond
;      [(draw-and-clear-picture picture) (translate-losh picture delta)]
;      [else picture]))
;           
;              ) (move-picture delta picture)))
;(define FACE
;  (cons (make-circle (make-posn 50 50) 40 'red)
;        (cons (make-rectangle (make-posn 30 20) 5 5 'blue)
;              (cons (make-rectangle (make-posn 65 20) 5 5 'blue)
;                    (cons (make-rectangle (make-posn 40 75) 20 10 'red)
;                          (cons (make-rectangle (make-posn 45 35) 10 30 'blue) empty))))))

;; cant really test it because it wont work with the
;; test that was used before in section 10
           
;; -------------------------
;;    Exercise 18.1.8.
;; -------------------------
;; Use local expression to organize functions for 
;; drawing a polygon in figure 34.
;(define (draw-polygon polygon)
;  (local (
;          (define (draw-polygon polygon)
;            (connect-dots (cons (last polygon) polygon)))
;          (define (connect-dots polygon)
;            (cond
;              [(empty? (rest polygon)) true]
;              [else (and (draw-solid-line (first polygon) 
;                                          (second polygon)
;                                          'black)
;                         (connect-dots (rest polygon)))]))
;          (define (last polygon)
;            (cond
;              [(empty? (rest polygon)) (first polygon)]
;              [else (last (rest polygon))])))
;    (draw-polygon polygon)))
;; test
;(start 100 100)
;(draw-polygon (list (make-posn 10 10) (make-posn 60 60) (make-posn 10 60)))


;; -------------------------
;;    Exercise 18.1.9.
;; -------------------------
;; Use local expression to organize functions for 
;; rearranging words from section 12.4.
(define (arrangements alist)
  (local (
          (define (arrangements alist)
            (cond
              [(empty? alist) (cons empty empty)]
              [else (insert-everywhere/in-all
                     (first alist) (arrangements (rest alist)))]))
          (define (insert-everywhere/in-all item alist)
            (cond
              [(empty? alist) empty]
              [else (append (insert-everywhere/in-one item (first alist))
                          (insert-everywhere/in-all item (rest alist)))]))
          (define (insert-everywhere/in-one item item2)
            (cond
              [(empty? item2) (list (cons item empty))]
              [else (cons
                     (append (list item (first item2)) (rest item2))
                     (insert-first/in-all (first item2)
                                          (insert-everywhere/in-one item (rest item2))))]))
          (define (insert-first/in-all item alist)
            (cond
              [(empty? alist) empty]
              [else (cons (cons item (first alist))
                          (insert-first/in-all item (rest alist)))]))
          ) (arrangements alist)))

;; test 
;(arrangements (list 'r 'e 'd 'r 'u 'm))
              

;; -------------------------
;;    Exercise 18.1.10.
;; -------------------------
;; Use local expression to organize functions for 
;; finding blue-eyed descendants from section 15.1.
; (define-struct parent (children name date eyes))
; (define (blue-eyed-descendant? parent)
;   (local (
;           ;; blue eyed-children? : list-of-children -> boolean
;           (define (blue-eyed-children? loc)
;             (cond
;               [(empty? loc) false]
;               [(blue-eyed-descendant? (first loc)) true]
;               [else (blue-eyed-children? (rest loc))]))
;           ;; blue-eyed-descendant? : parent -> boolean
;           (define (blue-eyed-descendant? parent)
;             (cond
;               [(empty? parent) false]
;               [(symbol=? (parent-eyes parent) 'blue) true]
;               [else (blue-eyed-children? (parent-children parent))]))
;           ) (blue-eyed-descendant? parent)))
; 
; ;; auxiliary stuff for testing
; ;; Youngest generation:
; (define Gustav (make-parent empty 'Gustav 1988 'brown))
; 
; (define Fred&Eva (list Gustav))
; 
; ;; Middle Generation:
; (define Adam (make-parent empty 'Adam 1950 'yellow))
; (define Dave (make-parent empty 'Dave 1955 'black))
; (define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
; (define Fred (make-parent Fred&Eva 'Fred 1966 'pink))
; 
; (define Carl&Bettina (list Adam Dave Eva))
; 
; ;; Oldest generation
; (define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
; (define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))

;; tests:
;(check-expect (blue-eyed-descendant? Eva) true)
;(check-expect (blue-eyed-descendant? Gustav) false)

;; ----------------------------------------

;; Pragmatics of local, Part 2

;; Suppose we need a function that produces the last occurence
;; of some item in a list, a list of rockstars
(define-struct star (name instrument))

;; A star is a structure 
;; (make-star n i)
;; where n and i are symbols

(define alos
  (list (make-star 'Richard 'saxophone)
        (make-star 'Penny 'vocals)
        (make-star 'Noodle 'guitar)
        (make-star 'Murdoc 'bass)
        (make-star '2D 'vocals)
        (make-star 'Russel 'drums)
        (make-star 'Richard 'doublebass)))
;; We want for richard -> doublebass
;; noodle-> guitar
;; 2D -> vocals
;; jeremy -> false 

;; last-occurence : symbol list-of-stars -> star or false
;; to find the last star record in a list of stars
;; that contains s in name field
(define (last-occurence s alostars)
  (cond
    [(empty? alostars) false]
    [else (local ((define r (last-occurence s (rest alostars))))
            (cond
              [(star? r) r]
              [(symbol=? (star-name (first alostars)) s) (first alostars)]
              [else false]))]))

;; -------------------------
;;    Exercise 18.1.11.
;; -------------------------
;; Evaluate the following expression by hand:
;; (last-occurence 'Matt (list (make-star 'Matt 'violin)
;;                             (make-star 'Matt 'radio)))
;; How many local-expressions are lifted?
;;
;;
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [(empty? (list (make-star 'Matt 'vi'Matt 'radio))) false]
;     [else (local ((define r (last-occurence 'Matt (rest (list (make-star 'Matt 'violin) (make-star 
;                      'Matt 'radio))))))
;             (cond
;               [(star? r) r]
;               [(symbol=? (star-name (first (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))) 'Matt) 
;                (first (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))]
;               [else false]))])
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r (last-occurence 'Matt (list (make-star 'Matt 'radio)))))
;             (cond
;               [(star? (last-occurence 'Matt (list (make-star 'Matt 'radio)) 
;                       (last-occurence 'Matt (list (make-star 'Matt 'radio)))))]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r 
;                     ;; recursive part
;   (cond
;     [(empty? (list (make-star 'Matt 'radio))) false]
;     [else (local ((define r (last-occurence 'Matt empty))))
;             (cond
;               [(star? (last-occurence 'Matt empty)) (last-occurence 'Matt empty)]
;               [(symbol=? 'Matt) 'Matt) (make-star 'Matt 'radio)]
;               [else false]))])
;                     ;; end of recursive part
;             (cond
;               [(star? (last-occurence 'Matt (list (make-star 'Matt 'radio)) 
;                       (last-occurence 'Matt (list (make-star 'Matt 'radio)))))]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r 
;                     ;; recursive part
;   (cond
;     [(empty? (list (make-star 'Matt 'radio))) false]
;     [else (local ((define r 
;                             ;; recursive part 2
;   (cond
;     [(empty? empty) false]
;     [else (local ((define r (last-occurence 'Matt empty))))
;             (cond
;               [(star? (last-occurence 'Matt empty)) (last-occurence 'Matt empty)]
;               [(symbol=? 'Matt) 'Matt) (make-star 'Matt 'radio)]
;               [else false]))])
;                             ;; end of recursive part 2
;             (cond
;               [(star? (last-occurence 'Matt empty)) (last-occurence 'Matt empty)]
;               [(symbol=? 'Matt) 'Matt) (make-star 'Matt 'radio)]
;               [else false]))])
;                     ;; end of recursive part
;             (cond
;               [(star? (last-occurence 'Matt (list (make-star 'Matt 'radio)) 
;                       (last-occurence 'Matt (list (make-star 'Matt 'radio)))))]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r 
;                     ;; recursive part
;   (cond
;     [(empty? (list (make-star 'Matt 'radio))) false]
;     [else (local ((define r 
;                             ;; recursive part 2
;   (cond
;     [true false]
;     [else (local ((define r (last-occurence 'Matt empty))))
;             (cond
;               [(star? (last-occurence 'Matt empty)) (last-occurence 'Matt empty)]
;               [(symbol=? 'Matt) 'Matt) (make-star 'Matt 'radio)]
;               [else false]))])
;                             ;; end of recursive part 2
;             (cond
;               [(star? (last-occurence 'Matt empty)) (last-occurence 'Matt empty)]
;               [(symbol=? 'Matt) 'Matt) (make-star 'Matt 'radio)]
;               [else false]))])
;                     ;; end of recursive part
;             (cond
;               [(star? (last-occurence 'Matt (list (make-star 'Matt 'radio)) 
;                       (last-occurence 'Matt (list (make-star 'Matt 'radio)))))]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r 
;                     ;; recursive part
;   (cond
;     [(empty? (list (make-star 'Matt 'radio))) false]
;     [else (local ((define r 
;                             ;; recursive part 2
;                       false)))]
;                             ;; end of recursive part 2
;             (cond
;               [(star? false) error ]
;               [(symbol=? 'Matt) 'Matt) (make-star 'Matt 'radio)]
;               [else false]))])
;                     ;; end of recursive part
;             (cond
;               [(star? (last-occurence 'Matt (list (make-star 'Matt 'radio)) 
;                       (last-occurence 'Matt (list (make-star 'Matt 'radio)))))]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
; 
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r 
;                     ;; recursive part
;   (cond
;     [(empty? (list (make-star 'Matt 'radio))) false]
;     [else (local ((define r 
;                             ;; recursive part 2
;                       false)))]
;                             ;; end of recursive part 2
;             (cond
;               [false error ]
;               [true (make-star 'Matt 'radio)]
;               [else false]))])
;                     ;; end of recursive part
;             (cond
;               [(star? (last-occurence 'Matt (list (make-star 'Matt 'radio)) 
;                       (last-occurence 'Matt (list (make-star 'Matt 'radio)))))]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
; 
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r 
;                     ;; recursive part
;               (make-star 'Matt 'radio)
;                     ;; end of recursive part
;             (cond
;               [(star? (make-star 'Matt 'radio))
;                       (make-star 'Matt 'radio)]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
;  ==
; 
; (last-occurence 'Matt (list (make-star 'Matt 'violin) (make-star 'Matt 'radio)))
;   (cond
;     [false false]
;     [else (local ((define r 
;                     ;; recursive part
;               (make-star 'Matt 'radio)
;                     ;; end of recursive part
;             (cond
;               [true
;                       (make-star 'Matt 'radio)]
;               [(symbol=? (star-name (make-star 'Matt 'violin)) 'Matt) 
;                (make-star 'Matt 'violin)]
;               [else false]))])
; 
;  ==
; 
;               (make-star 'Matt 'radio)
              
;; There were lifted 3 local expressions

;; -------------------------
;;    Exercise 18.1.12.
;; -------------------------
;; Consider the following function definition:
;; max : non-empty lon -> number
(define (max1 alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [(> (first alon) (max1 (rest alon))) (first alon)]
    [else (max1 (rest alon))]))

(define (max2 alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else
     (cond 
       [(> (first alon) (max2 (rest alon))) (first alon)]
       [else (max2 (rest alon))])]))

;; Create a version using local-expression and compare. Explain the effect.

(define (max3 alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (local ((define r (max3 (rest alon))))
                 (cond
                   [(> (first alon) r) (first alon)]
                   [else r]))]))

(define testlist (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 69 19 20))
(define testlist2 (list 1 2 5 2))
(max3 testlist2)

;; What do you know, the local-expression version is orders of magnitude faster.
;; For one, we dont have to check whether (rest alon) is empty every time we descend
;; down the list. Second - we assign value of (max (rest alon)), which we have to find only once
;; in every recursion, to variable r, whereas in our former version of function
;; we have to check repeatedly every single time.


;; -------------------------
;;    Exercise 18.1.13.
;; -------------------------
;;
;; A direction is either:
;;  1. symbol 'father or
;;  2. symbol 'mother
;;
;;  A path is:
;;  1. empty or
;;  2. (cons p los)
;;  where p is a direction and los is a path
;;
;; ANCESTORS, of course...
;; so we,re going to need child structure here.`
;; Auxiliary stuff, here we go:
(define-struct child (father mother name date eyes))
;; A child is a structure (make-child f m n d e)
;;  where:
;;  1. f and m are either:
;;      1.1. empty, or 
;;      1.2. child nodes
;;  2. n and e are symbols
;;  3. d is a number
;;
 ;; Oldest generation:
(define Carl (make-child empty empty 'Carl 1926 'purple))
(define Bettina (make-child empty empty 'Bettina 1926 'white))

;; Middle generation:
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Youngest generation:
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))
;;
;; My own code:
;; was close enough, outputs some unnecessary empty elements, which I could filter out
;; with some additional functions but that would be even more inefficient than it is now

;; to-blue-eyed-ancestor : ftn -> list / false
;; to compute a path from a family tree to a blue eyed ancestor
;;(define (to-blue-eyed-ancestor ft)
;;  (cond
;;    [(empty? ft) false]
;;    [else (local ((define (leads-to-blue-eyed-ancestor? parent)
;;                    (cond
;;                      [(empty? parent) false]
;;                      [(symbol=? (child-eyes parent) 'blue) true]
;;                      [(or (leads-to-blue-eyed-ancestor? (child-father parent))
;;                           (leads-to-blue-eyed-ancestor? (child-mother parent)))
;;                       true]
;;                      [else false]))
;;                  (define (blue-eyed-ancestor? ancestor)
;;                    (cond
;;                      [(empty? ancestor) false]
;;                      [(symbol=? (child-eyes ancestor) 'blue) true]
;;                      [else false]))
;;                  (define in-mother-tree (leads-to-blue-eyed-ancestor? (child-mother ft)))
;;                  (define in-father-tree (leads-to-blue-eyed-ancestor? (child-father ft)))
;;                  (define check-eyes (blue-eyed-ancestor? ft)))
;;            (cond
;;              [(not (or check-eyes in-mother-tree in-father-tree)) false]
;;              [else 
;;               (cond
;;                 [check-eyes empty]
;;                 [in-father-tree (cons 'father (cons (to-blue-eyed-ancestor (child-father ft)) empty))]
;;                 [in-mother-tree (cons 'mother (cons (to-blue-eyed-ancestor (child-mother ft)) empty))]
;;                 [else empty])]))]))
                      
;; This I got from suguni, some clever korean guy. Pretty nice solution
(define (to-blue-eyed-ancestor ftn)
  (cond
    [(empty? ftn) false]
    [(symbol=? (child-eyes ftn) 'blue) empty]
    [else
     (local
       ((define f (to-blue-eyed-ancestor (child-father ftn)))
        (define m (to-blue-eyed-ancestor (child-mother ftn))))
       (cond
         [(list? f) (cons 'father f)]
         [(list? m) (cons 'mother m)]
         [else false]))]))
      
;; examples, how it should work:
;; to-blue-eyed-ancestor : Gustav ->  (list 'mother)
;; to-blue-eyed-ancestor : Adam -> false
;; if we (define Hal (make-child Gustav Eva 'Gustav 1998 'hazel)), then
;; to-blue-eyed-ancestor : Hal -> (list 'father 'mother)

;(check-expect (to-blue-eyed-ancestor Gustav) (list 'mother))
;(check-expect (to-blue-eyed-ancestor Adam) false)
;(define Hal (make-child Gustav Eva 'Hal 1998 'hazel))
;(check-expect (to-blue-eyed-ancestor Hal) (list 'father 'mother))



;; -------------------------
;;    Exercise 18.1.14.
;; -------------------------

;; I'm supposed to discuss the function find from exercise 15.3.4 in terms of 
;; backtracking
;; k, did some googling, I think I sort of got it, what it means 



;; Pragmatics of local, Part 3

;; mult10 : list-of-digits  ->  list-of-numbers
;; to create a list of numbers by multiplying each digit on alod 
;; by (expt 10 p) where p is the number of digits that follow
;(define (mult10 alod)
 ; (cond
  ;  [(empty? alod) 0]
   ; [else (cons (* (expt 10 (length (rest alod))) (first alod))
    ;   	        (mult10 (rest alod)))]))

;(define (mult10 alon)
 ; (cond
  ;  [(empty? alon) empty]
   ; [else (local ((define a-digit (first alon))
    ;              (define p (length (rest alon))))
     ;       ;; -----------------------------------
      ;      (cons (* (expt 10 p) a-digit) (mult10 (rest alon))))]))

(define (mult10 alon)
  (cond
    [(empty? alon) empty]
    [else (local ((define a-digit (first alon))
                  (define the-rest (rest alon))
                  (define p (length the-rest)))
            ;; --------------------------------
            (cons (* (expt 10 p) a-digit) (mult10 the-rest)))]))

(equal? (mult10 (list 1 2 3)) (list 100 20 3))



;; -------------------------
;;    Exercise 18.1.15.
;; -------------------------

;; Consider following function definiton:
;; extract1: invetory -> invetory
;; to create an inventory from an-inv for all
;; those items that cost less than $1
;(define (extract1 an-inv)
;  (cond
;    [(empty? an-inv) empty]
;    [else (cond
;            [(<= (ir-price (first an=inv)) 1.00)
;             (cons (first an-inv) (extract1 (rest an-inv)))]
;            [else (extract1 (rest an-inv))])]))

;; Introduce a local expression for these expressions!
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) empty]
    [else (local ((define first_inv (first an-inv))
                  (define extract_rest_inv (extract1 (rest an-inv))))
            (cond
              [(<= first_inv 1.0)(cons first_inv extract_rest_inv)]
              [else extract_rest_inv]))]))

;(check-expect (extract1 (list 2.0 5.0 1.0 0.55 0.33 8.00)) (list 1.0 0.55 0.33))


;; BINDING occurences 
;; BOUND occurences

;; Lexical & Global scopes. Global scope = free occurence

;; Variables introduced in local definitions are bound to (local ... ) scope

;; sort : list-of-numbers  ->  list-of-numbers



;; -------------------------
;;    Exercise 18.2.2.
;; ------------------------

;; Check out what binds to what
(define (sortx alon)
  (local ((define (sortx alon)
	    (cond
	      [(empty? alon) empty]
	      [(cons? alon) (insert (first alon) (sortx (rest alon)))]))
	  (define (insert an alon)
	    (cond
	      [(empty? alon) (list an)]
	      [else (cond
		      [(> an (first alon)) (cons an alon)]
		      [else (cons (first alon) (insert an (rest alon)))])])))
    (sortx alon)))


;; -------------------------
;;    Exercise 18.2.2.
;; ------------------------

; (define x (cons 1 x))
;; Where is underlined occurence of x bound?

;; since each occurence of a variable receives its value from the corresponding binding
;; occurence, the variable x on the right would appear to be bound variable
;; as well as the one on the right, hence the error
;; we have no binding occurence of x there. thats what I think at least







