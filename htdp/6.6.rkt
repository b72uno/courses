;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |6.6|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; *********** 6.6.2. ***********
;; Data analysis & Design
 (define-struct circle (x y radius color))
;; A make-circle is a structure where (make-circle x y z) x is a posn structure;
;; y is a number and z is a symbol

;; Contract:
;; (fun-for-circle structure number symbol) -> graphical output
;; to draw a circle according to parameters given in input

;; Template:
;; (define (fun-for-circle x y radius color)
;; ... (circle-center x) ...
;; ... (circle-center y) ...
;; ... (circle-radius radius) ...
;; ... (circle-color color) ... )

;; Definition:
(define (draw-a-circle a-circle)
 (draw-circle (make-posn (circle-x a-circle) (circle-y a-circle))
               (circle-radius a-circle)
               (circle-color a-circle)))

;; Tests:
;(start 300 300)
;(draw-a-circle (make-circle 150 150 100 'Red))
;; expected value:
;true


;; *********** 6.6.3. ***********
;; Data analysis & design
;; (define-struct circle (x y radius color))
;; A make-circle is a structure where (make-circle x y z) x is a posn structure;
;; y is a number and z is a symbol

;; Contract:
;; (in-circle? structure posn) -> boolean
;; to determine whether a pixel (posn structure) is within the first structure
;; which is a circle

;; Template:
;; (define (fun-for-circle x y radius color)
;; ... (circle-center x) ...
;; ... (circle-center y) ...
;; ... (circle-radius radius) ...
;; ... (circle-color color) ... )

;; Definition:
(define (in-circle? a-circle posn)
  (and
   (and
   (< (- (circle-x a-circle) (circle-radius a-circle))
      (posn-x posn))
   (> (+ (circle-x a-circle) (circle-radius a-circle))
      (posn-x posn))
   )
   (and 
    (< (- (circle-y a-circle) (circle-radius a-circle))
       (posn-y posn))
    (> (+ (circle-y a-circle) (circle-radius a-circle))
       (posn-y posn))
    )
   )
  )

;; Tests:
;(in-circle? (make-circle 6 2 1 'Red) (make-posn 6 1.5))
;; expected value:
;true

;(in-circle? (make-circle 6 2 1 'Red) (make-posn 8 6))
;; expected value:
;false



;; *********** 6.6.4. ***********

;; Data analysis & Design
;; (define-struct circle (x y radius color))
;; A make-circle is a structure where (make-circle x y z) x is a posn structure;
;; y is a number and z is a symbol

;; Contract:
;; (translate-circle circle-struct delta) -> boolean / graphic response
;; to translate a circle to left or right depending on change in input

;; Template:
;; (define (fun-for-circle a-circle)
;; ... (circle-x a-circle) ....
;; ... (circle-y a-circle) ....
;; ... (circle-color a-circle) ...
;; ... (circle-radius a-circle) ...)

;; Definition:
(define (translate-circle a-circle delta)
  (make-circle (+ (circle-x a-circle) delta) (circle-y a-circle)
  (circle-radius a-circle) (circle-color a-circle)))

;; Tests:
;(translate-circle (make-circle 150 150 25 'Red) 50)
;; expected value:
;(make-circle 200 150 25 'Red)



;; *********** 6.6.5. ***********

;; Data analyis & design:
;; (define-struct circle (x y radius color))
;; A circle is a structure (make-circle x y z) where x is a posn-structure
;; y is a number and z is a smybol

;; Contract:
;; (clear-a-circle posn-struct number) -> graphical output / clears circle
;; to clear a circle depending on the inputs given

;; Template:
;; (define (fun-for-circle a-circle)
;; ... (circle-x a-circle) ...
;; ... (circle-y a-circle) ...
;; ... (circle-radius a-circle) ...
;; ... (circle-color a-circle) ...)

;; Definition:
(define (clear-a-circle a-circle)
  (clear-circle
   (make-posn (circle-x a-circle) (circle-y a-circle))
   (circle-radius a-circle)
   )
  )

;; Tests:
;(clear-a-circle (make-circle 150 150 100 'Red))
;; expected value:
;true

;; *********** 6.6.6. ***********

;; Data analyis & design:
;; defined before, see back

;; Contract:
;; (draw-and-clear-circle circle-struct) -> boolean
;; to draw and clear a circle according to input

;; Template:
;; from above

;; Definition:
(define (draw-and-clear-circle a-circle)
  (and 
   (draw-a-circle a-circle)
   (sleep-for-a-while 2)
   (clear-a-circle a-circle)
  ))

;; Tests:
;(start 300 300)
;(draw-and-clear-circle (make-circle 150 150 100 'Red))
;; expected values:
;true
;true


;; *********** 6.6.6+. ***********

;; Data analysis & design
;; not given

;; Contract:
;; move-circle : number circle -> circle
;; to draw and clear a circle, translate it by delta pixels

;; Template: not given

;; Definition:
(define (move-circle delta a-circle)
  (cond
    [(draw-and-clear-circle a-circle)
     (translate-circle a-circle delta)]
    [else a-circle]))

;; Tests or something?
;(start 200 100)
;(draw-a-circle
; (move-circle 10
;   (move-circle 10
;     (move-circle 10
;       (move-circle 10
;         (make-circle 100 50 25 'Red))))))
;; expected result:
;; graphical output moves circle 4 times 10 pixels to the right


;; *********** 6.6.7-12. ***********
;; SAME THING WITH JUST WITH A RECTANGLE INSTEAD OF A CIRCLE

;; Data analysis & design
(define-struct rectangle (x y width height color))
;; A rectangle is a structure (rectangle x y w h c) where x y w and h 
;; are numbers and c is a symbol

;; Contracts:
;; draw-a-rectangle : rectangle -> rectangle
;; to draw a rectangle according to input, rectangle is a structure
;; in-rectangle? : rectangle pixel -> boolean
;; to determine whether a pixel is within the rectangle (pixel is a posn-struct)
;; translate-rectangle : delta rectangle -> rectangle
;; to translate the rectangle left or right according to input
;; clear-a-rectangle : rectangle -> rectangle
;; to clear a rectangle according to input
;; draw-and-clear-rectangle : rectangle -> rectangle
;; to draw and clear a rectangle according to input

;; Template:
;; (define (fun-for-rect a-rectangle)
;; ... (rectangle-x a-rectangle) ...
;; ... (rectangle-y a-rectangle) ...
;; ... (rectangle-width a-rectangle) ...
;; ... (rectangle-height a-rectangle) ...
;; ... (rectangle-color a-rectangle) ...)

;; Definitions: 
(define (draw-a-rectangle a-rectangle)
  (draw-solid-rect
   (make-posn (rectangle-x a-rectangle) (rectangle-y a-rectangle))
   (rectangle-width a-rectangle)
   (rectangle-height a-rectangle)
   (rectangle-color a-rectangle)))

(define (in-rectangle? a-rectangle pixel)
  (and
   (and
    (>= (+ (rectangle-x a-rectangle) (rectangle-width a-rectangle)) (posn-x pixel))
    (<= (rectangle-x a-rectangle) (posn-x pixel)))
   (and
    (>= (+ (rectangle-y a-rectangle) (rectangle-height a-rectangle)) (posn-y pixel))
    (<= (rectangle-y a-rectangle) (posn-y pixel)))
   ))

(define (translate-rectangle a-rectangle delta)
  (make-rectangle 
   (+ (rectangle-x a-rectangle) delta)
   (rectangle-y a-rectangle)
   (rectangle-width a-rectangle)
   (rectangle-height a-rectangle)
   (rectangle-color a-rectangle)))

(define (clear-a-rectangle a-rectangle)
  (clear-solid-rect
   (make-posn
    (rectangle-x a-rectangle)
    (rectangle-y a-rectangle))
    (rectangle-width a-rectangle)
    (rectangle-height a-rectangle)))

(define (draw-and-clear-rectangle a-rectangle)
 (and (draw-a-rectangle a-rectangle)
  (sleep-for-a-while 2)
  (clear-a-rectangle a-rectangle)))   

(define (move-rectangle delta a-rectangle)
  (cond
    [(draw-and-clear-rectangle a-rectangle)
     (translate-rectangle a-rectangle delta)]
    [else a-rectangle]))

;; Tests:
;(start 250 250)
;(draw-a-rectangle (make-rectangle 100 100 50 20 'Blue)) 
;; // True
;(in-rectangle? (make-rectangle 50 50 100 40 'Blue) (make-posn 150 90)) 
;; // True
;(draw-and-clear-rectangle (make-rectangle 25 25 175 80 'Purple))
; // True; True
;(draw-a-rectangle 
 ;(move-rectangle 10
  ;  (move-rectangle 10
   ;     (move-rectangle 10
    ;        (move-rectangle 10 (make-rectangle 25 25 150 80 'Green))))))



;; ************** 7.4. ***************


;; Data definition
;; (define (fun-for-shape a-shape))
;; a-shape is a construct 
;; Contract & Purpose
;; fun-for-shape : a-shape -> graphical output / boolean
;; to consume a shape and do whatever fun-for-shape is supposed to do

;; Definitions:
(define (draw-shape a-shape)
  (cond
    [(circle? a-shape)(draw-a-circle a-shape)]
    [(rectangle? a-shape) (draw-a-rectangle a-shape)]
    ))
(define (translate-shape a-shape delta)
  (cond
    [(circle? a-shape) (translate-circle a-shape delta)]
    [(rectangle? a-shape) (translate-rectangle a-shape delta)]
    ))
(define (clear-shape a-shape)
  (cond
    [(circle? a-shape) (clear-a-circle a-shape)]
    [(rectangle? a-shape) (clear-a-rectangle a-shape)]
    ))
(define (draw-and-clear-shape a-shape)
  (cond
    [(circle? a-shape) (draw-and-clear-circle a-shape)]
    [(rectangle? a-shape) (draw-and-clear-rectangle a-shape)]
    ))
(define (move-shape delta a-shape)
  (cond
    [(circle? a-shape)  
     (draw-a-circle
 (move-circle delta
    (move-circle delta
        (move-circle delta
            (move-circle delta a-shape )))))
]
    [(rectangle? a-shape) 
     
     (draw-a-rectangle 
 (move-rectangle delta
  (move-rectangle delta
      (move-rectangle delta
         (move-rectangle delta a-shape )))))
]
    ))

;; Tests
(start 500 500)
(draw-shape (make-circle 250 250 100 'Red))
(draw-shape (make-rectangle 100 100 150 150 'Purple))
(sleep-for-a-while 2)
(translate-shape (make-circle 250 250 100 'Red) 20)
(translate-shape (make-rectangle 100 100 150 150 'Purple) -20)
(sleep-for-a-while 2)
(clear-shape (make-circle  250 250 100 'Red))
(clear-shape (make-rectangle 100 100 150 150 'Purple))
(sleep-for-a-while 2)
(move-shape 10  (make-circle 250 250 100 'Red))
(move-shape 20 (make-rectangle  100 100 150 150 'Purple))
;; Expected values: 
;; Cba to write em