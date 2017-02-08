;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname temp) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp")))))
;; -------------------------
;;    Exercise 18.1.8.
;; -------------------------
(define-struct star (name instrument))

;; A star is a structure 
;; (make-star n i)
;; where n and i are symbols

(define alostars
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

(last-occurence 'Richard alostars)