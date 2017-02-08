;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |9.2|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; Data definition & Contract, Purpose n stuff
(define l (cons 'truck (cons 'shovel (cons 'crayons empty))))
;; l is a list of stuff
;; contains-doll? : list-of-symbols -> boolean
;; to determine whether a list of symbols contain symbol 'doll

;; Template:
;(define (contains-doll? a-list-of-symbols)
;  (cond
;    [(empty? a-list-of-symbols) ...]
;    [else ... (first a-list-of-symbols) ...
;          ... (rest a-list-of-symbols) ...]))

;; Definition:
(define (contains-doll? a-list-of-symbols)
  (cond
    [(cons? a-list-of-symbols)
     (cond
         [(symbol=? (first a-list-of-symbols) 'doll)
           true]
          [else (contains-doll? (rest a-list-of-symbols))]
          )]
    [else 
     (cond
       [(empty? a-list-of-symbols) false]
       [else (error 'contains-doll? "expecting a list of symbols")]
       )]
    ))

(define (contains? a-list-of-symbols symbol)
  (cond
    [(cons? a-list-of-symbols)
     (cond
         [(symbol=? (first a-list-of-symbols) symbol)
           true]
          [else (contains? (rest a-list-of-symbols) symbol)]
          )]
    [else 
     (cond
       [(empty? a-list-of-symbols) false]
       [else (error 'contains? "expecting a list of symbols")]
       )]
    ))
  

;; Tests:

(boolean=? (contains? empty 'doll)
           false)
;;expected value: true

(boolean=? (contains? (cons 'ball empty) 'doll)
           false)
;; expected value: true

(boolean=? (contains? (cons 'doll empty) 'doll)
           true)
;; expected value: true

(boolean=? (contains? (cons 'bow (cons'ax (cons 'ball empty))) 'doll)
           false)
;; expected value: true

(boolean=? (contains-doll? (cons 'arrow (cons 'doll (cons 'ball empty))))
                           true)
;; expected value: true
           
           