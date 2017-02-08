;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9x) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; ****************************
;;           LISTS!
;; ****************************
;(cons 'Sun empty)
;(cons 'Mercury 
;      (cons 'Venus 
;            (cons 'Earth 
;                  (cons 'Mars 
;                        (cons 'Jupiter 
;                              (cons 'Saturn 
;                                    (cons 'Uranus 
;                                          (cons 'Neptune 
;                                                empty)
;                                          )
;                                    )
;                              )
;                        )
;                  )
;            )
;      )
;
;
;(cons 'Red 
;      (cons 'Green
;            (cons 'Blue empty )))
;
;(cons 'RobyyRound
;      (cons 3
;            (cons true
;                  empty )))


;; add-up-3 : list-of-3-numbers -> number
;; to add up the three numbers in a-list-of-3-numbers

;; Examples and tests:
;; (= (add-up-3 (cons 2 (cons 1 (cons 3 empty)))) 6)
;; (= (add-up-3(cons 0 (cons 1 (cons 0 empty)))) 1)

;; Template and what not
;(define (add-up a-list-of-numbers)
;  ... (first a-list-of-3-numbers) ...
;  ... (first (rest a-list-of-3-numbers)) ...
;  ... (first (rest (rest a-list-of-3-numbers))) ...)

;; Definition:
(define (add-up-3 a-list-of-3-numbers)
  (+ (first a-list-of-3-numbers) 
  (first (rest a-list-of-3-numbers)) 
  (first (rest (rest a-list-of-3-numbers)))))

(define a-list-of-3-numbers (cons 10 (cons 20 (cons 5 empty ))))

(define l (cons 10 (cons 20 (cons 5 empty))))

;; Now do fancy thingy distance to 0 definition, same stuff 
;; cba 2 document
(define (distance-to-0-for-3 a-list-of-3-numbers)
  (sqrt
   (+
    (sqr (first a-list-of-3-numbers))
    (sqr (first (rest a-list-of-3-numbers)))
    (sqr (first (rest (rest a-list-of-3-numbers))))
    )))
;; Tests:
;(distance-to-0-for-3 l)
;; expected value:
;22.912





        

