;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |10.3|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp")))))
;; *********************** ***********************
;;                      10.3.
;;      EXTENDED EXERCISE: MOVING PICTURES
;; **********************************************
;; 
;; *********
;;  10.3.1.
;; *********

;; New circle & &square definitions, adds from earlier in chap 7
(define-struct circle (center radius color))
(define-struct rectangle (nw width height color))
;; draw-a-circle: circle -> true
;; consumes a circle and draws it based off of the 
;; center, radius, and color
(define (draw-a-circle a-circle)
  (draw-circle (make-posn (posn-x (circle-center a-circle))
                          (posn-y (circle-center a-circle)))
               (circle-radius a-circle)
               (circle-color a-circle)))
;; draw-a-rectangle: rectangle -> true
;; consumes a rectange and draws it based off of the 
;; nw corner, width, height, and color
(define (draw-a-rectangle a-rectangle)
  (draw-solid-rect (make-posn (posn-x (rectangle-nw a-rectangle))
                              (posn-y (rectangle-nw a-rectangle)))
                   (rectangle-width a-rectangle)
                   (rectangle-height a-rectangle)
                   (rectangle-color a-rectangle)))
;; translate-circle: circle delta -> circle
;; takes in a circle and a delta and makes a new circle
;; that is translated delta units to the right
(define (translate-circle a-circle delta)
  (make-circle (make-posn (+ (posn-x (circle-center a-circle)) delta)
                          (posn-y (circle-center a-circle)))
               (circle-radius a-circle)
               (circle-color a-circle)))
;; translate-rectangle: rectangle delta -> rectangle
;; consumes a rectangle and delta and makes a new rectangle
;; that is translated delta units to the right
(define (translate-rectangle a-rectangle delta)
  (make-rectangle (make-posn (+ (posn-x (rectangle-nw a-rectangle)) delta)
                             (posn-y (rectangle-nw a-rectangle)))
                  (rectangle-width a-rectangle)
                  (rectangle-height a-rectangle)
                  (rectangle-color a-rectangle)))

;; clear-a-circle: circle -> true
;; consumes a circle and clears it from the canvas
;; based off of the center, radius, and color
(define (clear-a-circle a-circle)
  (clear-circle (circle-center a-circle)
                (circle-radius a-circle)
                (circle-color a-circle)))

;; clear-a-rectangle rectangle ->
;; consumes a rectangle and clears it from the canvas
;; based off of the nw, width, height, color
(define (clear-a-rectangle a-rectangle)
  (clear-solid-rect (make-posn (posn-x (rectangle-nw a-rectangle))
                               (posn-y (rectangle-nw a-rectangle)))
                    (rectangle-width a-rectangle)
                    (rectangle-height a-rectangle)
                    (rectangle-color a-rectangle)))



;; (define list-of-shapes (list (... ( list empty)..))
;; list-of-shapes is a list containing a bunch of shapes
;; among which are rectangles and circles with different parameters

(define FACE
  (cons (make-circle (make-posn 50 50) 40 'red)
        (cons (make-rectangle (make-posn 30 20) 5 5 'blue)
              (cons (make-rectangle (make-posn 65 20) 5 5 'blue)
                    (cons (make-rectangle (make-posn 40 75) 20 10 'red)
                          (cons (make-rectangle (make-posn 45 35) 10 30 'blue) empty))))))

;; FACE is a list-of-shapes

;; Contract or what not, still have no calrity what
;; I am suppose to write as a title here for this part
;; Exercises like the one to develop a template or what not
;; before stating what the function should do, confuses me
;; and I have no idea whether I have to define something before
;; the definition of a template or not. w/e here goes:
;; (define (fun-for-losh list-of-shapes) ...)
;; fun-for-losh is a function which consumes a-list-of-shapes
;; and does something something with them 

;; fun-for-losh : a-list-of-shapes -> graphical output on canvas
;; to consume a list of shapes and draw them

;; Template:
;(define (fun-for-losh a-losh)
;  (cond
;    [(empty? a-losh) false]
;    [(circle? (first a-losh)) ...]
;    [(rectangle? (first a-losh)) ...]
;    [else ...]))

;; Definitions:
;; I am not going to write the whole thing again so I'm defining
;; EVERYTHING 10.3.2. - 10.3.6.
(define (draw-losh losh)
  (cond
    [(empty? losh) true]
    [else (cond
            [(circle? (first losh)) (and 
                                     (draw-a-circle (first losh))
                                     (draw-losh (rest losh)))]
            [else (and
                   (draw-a-rectangle (first losh))
                   (draw-losh (rest losh)))])]))

(define (translate-losh losh delta)
  (cond
    [(empty? losh) empty]
    [else (cond
            [(circle? (first losh)) (cons (translate-circle (first losh) delta)
                                          (translate-losh (rest losh) delta))]
            [else (cons (translate-rectangle (first losh) delta)
                        (translate-losh (rest losh) delta))])]))

(define (clear-losh losh)
  (cond
    [(empty? losh) true]
    [else (cond
            [(circle? (first losh)) (and
                                     (clear-a-circle (first losh))
                                     (clear-losh (rest losh)))]
            [else (and
                   (clear-a-rectangle (first losh))
                   (clear-losh (rest losh)))])]))


;; draw-and-clear-picture : picture -> true
  (define (draw-and-clear-picture picture)
    (and (draw-losh picture)
    (sleep-for-a-while 1)
    (clear-losh picture)))
  

  
  (define (move-picture delta picture)
    (cond
      [(draw-and-clear-picture picture) (translate-losh picture delta)]
      [else picture]))
  
  
;; Test:
;(start 300 100)
;(draw-losh FACE)
;(translate-losh FACE 10)
;(draw-losh
; (move-picture -55 
 ;  (move-picture 23
  ;    (move-picture 10 FACE))))
;(stop) 


(start 500 100)

(control-left-right FACE 100 move-picture draw-losh)

;; COPY PASTED FROM SOMEBODY ELSE
;; VALUABLE LESSONS LEARNED:
;;    - Always have a contract above ALL definitions
;;    - Pass the parameter which the function will have to operate on FIRST
;;    - Think with your head