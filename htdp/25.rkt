;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |25|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;;  ---------------------------
;;          Section 25
;; ----------------------------


;;        Part V
;;   General Recursion

;; A New Form of Recursion


;; - The study of ALGORITHMS

;; There are 2 kinds of problems:
;;  - those that are TRIVIALLY SOLVABLE
;;  - and those that are not

;; A non-trivial problem can be solved by new, smaller problems.
;; In a computational setting one of the smaller problems often
;; belongs to the same class of problems as the original one,
;; and it is for this reason that we call the approach
;;  - GENERATIVE RECURSION.

;; Algorithms = functions based on generative recursion.

;; Programmers: structural vs generative recursion.
;; Mathematical CS: recursions vs iterations


;; 25.1. Modeling a Ball on a Table
;; ---------------------------------

;; We can model the table with a canvas of some fixed width and height. 
;; The ball is a disk that moves across the canvas, which we express 
;; with drawing the disk, waiting, and clearing it, until it is out 
;; of bounds.

;; TeachPack: draw.ss 

(define-struct ball (x y delta-x delta-y))
;; A ball is a structure: 
;;   (make-ball number number number number)

;; draw-and-clear : a-ball  ->  true
;; draw, sleep, clear a disk from the canvas 
;; structural design, Scheme knowledge
(define (draw-and-clear a-ball)
  (and
   (draw-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)
   (sleep-for-a-while DELAY)
   (clear-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)))

;; move-ball : ball  ->  ball
;; to create a new ball, modeling a move by a-ball
;; structural design, physics knowledge
(define (move-ball a-ball) 
  (make-ball (+ (ball-x a-ball) (ball-delta-x a-ball))
             (+ (ball-y a-ball) (ball-delta-y a-ball))
             (ball-delta-x a-ball)
             (ball-delta-y a-ball)))

;; Dimension of canvas 
(define WIDTH 100)
(define HEIGHT 100)
(define DELAY 1)

;; out-of-bounds? : a-ball  ->  boolean
;; to determine whether a-ball is outside of the bounds
;; domain knowledge, geometry
(define (out-of-bounds? a-ball)
  (not
   (and
    (<= 0 (ball-x a-ball) WIDTH)
    (<= 0 (ball-y a-ball) HEIGHT))))


;; move-until-out : a-ball  ->  true
;; to model the movement of a ball until it goes out of bounds
;; move-until-out : a-ball  ->  true
;; to model the movement of a ball until it goes out of bounds
(define (move-until-out a-ball)
  (cond
    [(out-of-bounds? a-ball) true]
    [else (and (draw-and-clear a-ball)
               (move-until-out (move-ball a-ball)))]))

;(start WIDTH HEIGHT)
;(move-until-out (make-ball 10 20 -6 12))
;(stop)


;; -------------------------
;;    Exercise 25.1.1.
;; -------------------------

;; If we try (move-until-out (make-ball 10 20 0 0))
;; the expression will not terminate. Could this happen
;; with any of the functions designed according
;; to our old recipes? Hmm not sure. I guess, yes, it could.

;; -------------------------
;;    Exercise 25.1.2.
;; -------------------------

;; Develop move-balls. The function consumes a list of balls
;; and moves each one until all of them have moved out of bounds.

;; Hint: best to write function using filter, andmap and similar
;; abstract functions from part IV.


;; move-balls : (listof X) -> (listof X)
;; to consume a list of balls and move all them out of bounds.
(define (move-balls lob)
  (map move-until-out lob))

;(start WIDTH HEIGHT)
;(move-balls
;               (list (make-ball 10 20 -6 12)
;                     (make-ball 25 34 -4 13)
;                    (make-ball 50 50 4 13)))

;; Output might be useless - a list of true,
;; and it wont terminate if (make-ball x y 0 0) is fed
;; as an input among list items, other than that, 
;; it gets the job done.



;; 25.2. Sorting Quickly
;; -----------------------

;; Quicksort algorithm is classic example of
;; generative recursion in computing.

;; sort is based on structural recursion,
;; qsort is based on generative recursion.

;; - Divide & Conquer.

;; -------------------------
;;    Exercise 25.2.1.
;; -------------------------

;; Simulate all qsort steps for (list 11 9 2 18 12 4 1)
;; (qsort (list 11 9 2 18 12 4 1) ->
;; (9 2 4 1) 11 ( 18 12) ->
;; (2 4 1) 9 empty 11 12 18 empty
;; (1) 2 (4) 9 empty 11 12 18 empty
;; empty 1 empty 2 empty 4 empty 9 empty 11 12 18 empty
;; 1 2 4 9 11 12 18

;; QSort distinguishes 2 cases - if the input is empty, it
;; produces empty. Otherwise, it performs a generative
;; recursion, hence the cond expression:

;; quick-sort : (listof number) -> (listof number)
;; to create a list of numbers with the same numbers
;; as alon sorted in ascending order
(define (quick-sort alon)
  (cond
    [(empty? alon) empty]
    [(empty? (rest alon)) alon] ;; Mod#1
    ;; Since the rest of the list is of unknown size, we 
    ;; need 2 auxiliary functions (smaller-items and larger-items)
    ;; to partition the list.
    [else (append (quick-sort (smaller-items alon (first alon)))
                  (same-items alon (first alon)) ;; Mod#2
                  (quick-sort (larger-items alon (first alon))))]))

;; larger-items : (listof number) number -> (listof number)
;; to create a list with all those numbers on alon
;; that are larger than thereshold
(define (larger-items alon threshold)
  (cond
    [(empty? alon) empty]
    [else (if (> (first alon) threshold)
              (cons (first alon) (larger-items (rest alon) threshold))
              (larger-items (rest alon) threshold))]))

;; smaller-items : (listof number) number -> (listof number)
;; to create a list with all those numbers on alon
;; that are smaller than thereshold
(define (smaller-items alon threshold)
  (cond
    [(empty? alon) empty]
    [else (if (< (first alon) threshold)
              (cons (first alon) (smaller-items (rest alon) threshold))
              (smaller-items (rest alon) threshold))]))

;; -------------------------
;;    Exercise 25.2.2.
;; -------------------------
;; Complete the above hand-evaluation.
;; No, thank you.

;; Modify the def of quick-sort to take advantage of the fact that
;; when quick-sort consumes list of 1 item, it produces the very
;; same list. ;; Mod#1

;; How many steps does it save? Depends.

;; -------------------------
;;    Exercise 25.2.3.
;; -------------------------
;; Develop a version of quick-sort that uses sort from
;; section 12.2 if the length of the input is below some
;; threshold.

;; Develop a function to check input size, then add 1 cond
;; expression to the quick-sort. Thats the way I'd go about it.

;; -------------------------
;;    Exercise 25.2.4.
;; -------------------------

;; If the input to quick-sort contains the same number several times,
;; the algorithm returns a list that is strictly shorter than the input.
;; Why? Fix the problem so that the output is as long as the input
;; Mod#2
(define (same-items alon pivot) (filter (lambda (x) (= x pivot)) alon))
;(quick-sort (list 4 4 3 3 3 2 2 2 5))


;; -------------------------
;;    Exercise 25.2.5.
;; -------------------------
;; Use the filter to define smaller items and larger items as one-liners.
;(define (smaller-items alon pivot) (filter (lambda (x) (< x pivot)) alon))
;(define (larger-items alon pivot) (filter (lambda (x) (> x pivot)) alon))

;; -------------------------
;;    Exercise 25.2.6.
;; -------------------------
;; Develop a variant of quick-sort that uses only one comparison, say <. Its partitioning
;; step divides the given list alon into a list that contains the items of a lon smaller than (first alon)
;; and another one with those that are not smaller.

;; Use local to combine functions into a single function. Then abstract the new version to consume a 
;; list and a comparison function
;; general-quick-sort : (X X -> bool) (listof X) -> (listof X)
(define (general-quick-sort predicate alon)
  (if (or (empty? alon) (empty? (rest alon))) alon 
      
      (append (general-quick-sort predicate 
                                  (filter (lambda (x) (predicate x (first alon))) 
                                  (rest alon)))
              
              (list (first alon))
              
              (general-quick-sort predicate 
                                  (filter (lambda (x) (not (predicate x (first alon)))) 
                                  (rest alon))))))

(check-expect (general-quick-sort < (list 5 2 1 1 4 5)) (list 1 1 2 4 5 5))

          