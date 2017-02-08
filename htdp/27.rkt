;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |27|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
 ;;  ---------------------------
;;          Section 27
;; ----------------------------


;; Section 27
;; Variations on a Theme
;; ----------------------


;; Its important to understand the generative
;; ideas behind the algorithms so that they can be
;; applied in other contexts.

;; The first example is a graphical illustration - 
;; The Sierpinski triangle.
;; The second concerns parsing, i.e. dissecting sequences of symbols.
;; The third one explains the divide-and-conquer principle.


;; Section 27.1
;; Fractals
;; ----------------------

;; sierpinski : posn posn posn -> true
;; to draw a Sierpinski triangle down at a, b and c
;; assuming it is large enough.
(define (sierpinski a b c)
  (if (too-small? a b c) 
       true
      (local
        ((define a-b (mid-point a b))
         (define b-c (mid-point b c))
         (define c-a (mid-point a c)))
        (and 
         (draw-triangle a b c)
         (sierpinski a a-b c-a)
         (sierpinski b a-b b-c)
         (sierpinski c c-a b-c)))))

;; mid-point : posn posn -> posn
;; to compute the mid point between a-posn and b-posn
(define (mid-point a-posn b-posn)
  (make-posn (mid (posn-x a-posn) (posn-x b-posn))
             (mid (posn-y a-posn) (posn-y b-posn))))

;; mid : number number -> number
;; to compute the average of x and y
(define (mid x y)
  (/ (+ x y) 2))


;; -------------------------
;;    Exercise 27.1.1.
;; -------------------------
;; Develop the functions 
;; draw-triange and too-small?
;; Use teachpak draw.ss to test the code.



