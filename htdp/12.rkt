;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |12|) (read-case-sensitive #t) (teachpacks ((lib "draw.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.ss" "teachpack" "htdp")))))
;; ## CHAPTER 12 ##
;; ----------------------------
;; DEVELOPING COMPLEX PROGRAMS
;; - keep a wish list of functions and variables needed


;; Data analysis & design
;; (define (sort alon) ...)
;; sort is a function which consumes a list of numbers and outputs
;; another list of numbers which is sorted in specific order
;; ASC to DESC in our case

;; Contract & purpose
;; sort : listOfNumbers -> listOfNumbers
;; to create a sorted list of numbers from all the numbers in alon

;; Examples:
;; (sort empty)
;; expected value:
;; empty
;; (sort (cons 1297.04 (cons 2000.00 (cons -505.25 empty)))
;; expected value:
;; (cons 2000.00 (cons 1297.04 (cons -505.25 empty)))

;; Template:
;;(define (sort alon)
;;  (cond
;;    [(empty? alon) ... ]
;;    [else ... (first alon) ... (sort (rest alon)) ... ]))

;; Definition:
(define (sort alon)
  (cond
    [(empty? alon) empty]
;; how the heck we do this? auxiliary functions to the rescue!
    [else (insert (first alon) (sort (rest alon)))]))

;; WISH LIST ************

;; insert : number listOfNumbers -> listOfNumbers
;; to create a list of numbers from n and the list of numberso n alon
;; that is sorted in descending order; alon is already sorted
;; (define (insert n alon) ...)

;; examples:
;; (insert 5 empty)
;; expected value:
;; (cons 5 empty)
;; (insert 1297.04 (cons 2000.00 (cons -505.25 empty)))
;; expected value:
;; (cons 2000.00 (cons 1297.04 ( cons -505.25 empty)))

;; Template:
;;(define (insert n alon)
;;  (cond
;;    [(empty? alon) (cons n empty)]
;;    [else ... (first alon) ... (insert n (rest alon)) 
;;         (cond
;;           [(>= n (first alon)) ... ]
;;           [(< n (first alon)) ...]) ...]))

;; Definition:
(define (insert n alon)
  (cond
    [(empty? alon) (cons n empty)]
    [else
     (cond
       [(>= n (first alon)) (cons n alon)]
       [(< n (first alon)) (cons (first alon) (insert n (rest alon)))])]))

;(check-expect (insert 5 empty) (cons 5 empty))
;(check-expect (insert 1297.04 (cons 2000.00 (cons -505.25 empty))) (cons 2000.00 (cons 1297.04 ( cons -505.25 empty))))
;; aand we have defined insertion sort!



;; ----------------------------
;; ## EXERCISE 12.2.1. ##
;; Develop a program that sorts mail messages by date and one that sorts by name.
;; Use string<? primitive to compare alphabetically.

;; Mail is a structure:
(define-struct mail (from date message)) 
;; where from is a string date is a number and message is a string

;; sortMailByDate : list -> list
;; to sort a list of mail by date
(define (sortMailByDate alon)
  (cond
    [(empty? alon) empty]
    [else (insertMailDate (first alon) (sortMailByDate (rest alon)))]))
;; insert : n alon -> alon
;; to insert n into a sorted list of numbers
(define (insertMailDate mail alon)
  (cond
    [(empty? alon) (cons mail empty)]
    [else
     (cond
       [(>= (mail-date mail) (mail-date (first alon))) (cons mail alon)]
       [(< (mail-date mail) (mail-date (first alon))) (cons (first alon) (insertMailDate mail (rest alon)))])]))

;(check-expect (insertMailDate (make-mail 'John 25 'oHai) empty) (cons (make-mail 'John 25 'oHai) empty))
;(check-expect (insertMailDate (make-mail 'Liu 13 'HurrDurr) (cons (make-mail 'Jane 21 'HoldOn) (cons (make-mail 'Kyra 9 'AreYouWithMe?) empty))) (cons (make-mail 'Jane 21 'HoldOn) (cons (make-mail 'Liu 13 'HurrDurr) (cons (make-mail 'Kyra 9 'AreYouWithMe?) empty))))


;; sortMailByName : list -> list
;; to sort a list of mail by persons name
(define (sortByName alon)
  (cond 
    [(empty? alon) empty]
    [else (insert (first alon) (sortByName (rest alon)))]))

;; insertMailName : mail alom -> alom
;; inserts a mail entry into a sorted list alphabetically by name
(define (insertByName mail alom)
  (cond
    [(empty? alom) (cons mail empty)]
    [else
     (cond
       [(string<=? (mail-from mail) (mail-from (first alom))) (cons mail alom)]
       [(string>? (mail-from mail) (mail-from (first alom))) (cons (first alom) (insertByName mail (rest alom)))]
       )]))

;; Tests:
;(check-expect (insertByName (make-mail "Jin" 25 "Hello") empty) (cons (make-mail "Jin" 25 "Hello") empty))
;(check-expect (insertByName (make-mail "Jin" 25 "Hello")
;                            (cons (make-mail "Angel" 10 "Hey there")
;                                  (cons (make-mail "Jenny" 20 "Sup, man?")
;                                        (cons (make-mail "Mandy" 29 "Well, hello!")
;                                              empty))))
;              (cons (make-mail "Angel" 10 "Hey there")
;                    (cons (make-mail "Jenny" 20 "Sup, man?")
;                          (cons (make-mail "Jin" 25 "Hello")
;                                (cons (make-mail "Mandy" 29 "Well, hello!")
;                                              empty)))))
;; works! very very nice!




;; ----------------------------
;; ## EXERCISE 12.2.2. ##
;; Develop the function searchSorted which determines whether a number
;; occurs in a sorted list of numbers
;; the function MUST take advantage of the fact that the list is sorted!

;; search : number listOfNumbers -> boolean
(define (search n alon)
  (cond
    [(empty? alon) false]
    [else (or (= (first alon) n) (search n (rest alon)))]))

;; I guess this was an example for a search which doesnt take the advantage


;; searchSorted : number listOfNumbers -> boolean
(define (searchSorted n alon)
  (cond
    [(or
      (empty? alon)
      (< (first alon) n)) false]
    [else (or (= (first alon) n) (searchSorted n (rest alon)))]))

;; Tests:
;; Auxiliary stuff:
(define List (cons 5 (cons 9 (cons 2 (cons 4 (cons 10 (cons 25 (cons 16 empty))))))))
(define sortedList (cons 25 (cons 16 (cons 10  (cons 9 (cons 5 (cons 4 (cons 2 empty))))))))

;(check-expect (search 4 List) true)
;(check-expect (searchSorted 4 List)  false)
;(check-expect (search 14 sortedList) false)
;(check-expect (searchSorted 24 sortedList) false)


;;; ----------------------------
;;; ## EXERCISE 12.3.##
;;;
;;; Consider drawing a polygon - geometric shape with
;;; an arbitrary number of corners
;
;;; A list-of-posns is either:
;;; 1. the empty list, empty, or
;;; 2. (cons p lop) where p is a posn structure and lop is a list of posns
;
;;; Each posn represents one corner of the polygon. For example:
;;; (cons (make-posn 10 10)
;;;      (cons (make-posn 60 60)
;;;            (cons (make-posn 10 60)
;;;                  empty)))
;;; represents a triangle
;;;
;;; A polygon is either:
;;; (cons p empty) where p is a posn or
;;; (cons p lop) where p is a posn structure and lop is polygon
;;;
;;; drawPolygon : polygon -> true
;;; to draw the polygon specified by aPoly
; (define (connectDots aPoly) 
;   (cond
;     [(empty? (rest aPoly)) true]
;     [else
;      (and (draw-solid-line (first aPoly) (second aPoly))
;      (connectDots (rest aPoly)))]))
;
;;; This function will only connect the dots tho, it will not
;;; connect the last dot with the first one therefore it wont create
;;; the polygon we desire either.
; 
;;; To make it work we need to develop an auxiliary function
;;;
;;; One way would be to add the last item(dot) of a polygon at the beginning 
; ;; or the other way around. or you cold modify the original drawPolygon
; ;; so it works as we need.
; ;; ex: (cons (last a-poly) a-poly) this covers 2nd method.
; 
; ;; last : polygon -> posn
; ;; to extract the last posn on a poly
; (define (last aPoly)
;   (cond
;     [(empty? (rest aPoly)) (first aPoly)]
;     [else (last (rest aPoly))]))
; 
;;; drawPolygon : polygon -> true
;;; to draw the polygon specified by aPoly
;(define (drawPolygon1 aPoly)
;  (connectDots (cons (last aPoly) aPoly)))
; 
;;; 1st and 3rd methods are covered in exercises:
;;; 1st - to add the first item to the end
;
;(define triangle (cons (make-posn 10 10)
;  (cons (make-posn 60 60)
;    (cons (make-posn 10 60)
;      empty))))
;
;;; 2nd - 
;;; drawPolygon2 : polygon -> true
;;; to draw a polygon, but this time it should
;;; add the first item of aPoly to its end.
;;; requires an auxiliary function addAtEnd.
;(define firstItem (first triangle))
;;(define firstItem 10)
;;; addAtEnd : list item -> list
;(define (addAtEnd aPoly firstItem)
;  (cond
;    [(empty? (rest aPoly)) (cons (first aPoly) 
;                                 (cons firstItem (rest aPoly)))]
;    [else
;     (cons (first aPoly) (addAtEnd (rest aPoly) firstItem))]))
;
;;(check-expect (addAtEnd (cons 10 (cons 9 (cons 8 (cons 7 empty)))) firstItem)
;;              (cons 10 (cons 9 (cons 8 (cons 7 (cons 10 empty))))))
;
;;; drawPolygon2 : list -> true
;(define (drawPolygon2 aPoly)
;  (connectDots (addAtEnd aPoly firstItem)))
;
;
;;; 3rd -
;;; modifying connectDots to consume an additional posn structure
;;; to which the last posn is connected
;;
;(define (connectDots2 aPoly aPosn)
;  (cond
;    [(empty? (rest aPoly)) (draw-solid-line (first aPoly) aPosn)]
;    [else
;     (and (draw-solid-line (first aPoly) (second aPoly))
;          (connectDots2 (rest aPoly) aPosn))]))
;
;(define (drawPolygon3 aPoly)
;  (connectDots2  aPoly (first aPoly)))
;
;; Tests:
;; (start 100 100)
;;(drawPolygon1 triangle)
;;(drawPolygon2 triangle)
;;(drawPolygon3 triangle)
;

 
;; ----------------------------
;; ## EXTENDED EXERCISE 12.4.##

;; A word is either:
;; 1. empty , or
;; 2. (cons a w) where a is a symbol ('a, 'b, ... 'z) and w is a word

;; A list of words is either:
;; 1. (cons a empty), where a is a word, or
;; 2. (cons a w) where a is a word structure and w is a list of words

;; Examples:
;; Word
;(cons 'c (cons 'a (cons 't empty))) ; => cat
;; List-of-words
;(cons (cons 'c (cons 'a (cons 't empty))) ;; cat
;      (cons (cons 'c (cons 't (cons 'a empty))) ;; cta
;            (cons (cons 'a (cons 'c (cons 't empty))) ;; act
;                  (cons (cons 'a (cons 't (cons 'c empty))) ;; atc
;                        (cons (cons 't (cons 'a (cons 'c empty))) ;; tac
;                              (cons (cons 't (cons 'c (cons 'a empty))) ;; tca
;                                    empty))))))
;; ~= (cons "cat" (cons "cta" (cons "act" (cons "atc" (cons "tac" (cons "tca" empty))))))

;; ## Exercise 12.4.1.##
;; arrangements : word -> list of words
;; to create a list of all rearrangements of letters in a-word
;(define (arrangements a-word)
;  (cond
;    [(empty? a-word) ...]
;    [else ... (first a-word) ... (arrangements (rest a-word)) ...]))

(define (arrangements a-word)
  (cond
    [(empty? a-word) (cons empty empty)]
    [else (insert-everywhere/in-all-words (first a-word)
                                          (arrangements (rest a-word)))]))

;; insert-everywhere/in-all-words : a-word alow -> alow
;; insert-everywhere/in-all-words is a function which consumes
;; a symbol and a list of words and outputs a list of words
;; like its second argument but with the first argument inserted between all letters 
;; and at the beginning and the end of all words of the second argument

;; insert-everywhere/in-all-words : symbol list-of-words -> list-of-words
(define (insert-everywhere/in-all-words c low)
  (cond
    [(empty? low) empty]
    [else (append (insert-everywhere/in-a-word c (first low))
                  (insert-everywhere/in-all-words c (rest low)))]))

;; insert-everywhere/in-a-word : symbol word -> list-of-words
(define (insert-everywhere/in-a-word c word)
  (cond
    [(empty? word) (list (cons c empty))]
    [else
     (cons (append (list c (first word)) (rest word))
           (insert-first/in-all-words (first word) (insert-everywhere/in-a-word c (rest word))))]))

(define (insert-first/in-all-words c low)
  (cond
    [(empty? low) empty]
    [else
     (cons (cons c (first low))
           (insert-first/in-all-words c (rest low)))]))
;
;;; test
;(check-expect (insert-everywhere/in-a-word 'd empty)
;              (cons (cons 'd empty) empty))
;
;(check-expect (insert-everywhere/in-a-word 'd (cons 'e empty))
;              (list (cons 'd (cons 'e empty))   ; de
;                    (cons 'e (cons 'd empty)))) ; ed
;
;(check-expect (insert-everywhere/in-a-word 'd (cons 'e (cons 'r empty)))
;              (list (cons 'd (cons 'e (cons 'r empty)))   ; der
;                    (cons 'e (cons 'd (cons 'r empty)))   ; edr
;                    (cons 'e (cons 'r (cons 'd empty))))) ; erd
;;; test
;(check-expect (insert-first/in-all-words 'd (list (cons 'e (cons 'r empty))
;                                                  (cons 'r (cons 'e empty))))
;              (list (cons 'd (cons 'e (cons 'r empty)))
;                    (cons 'd (cons 'r (cons 'e empty)))))

(insert-everywhere/in-all-words
               'd (list (cons 'e (cons 'r empty))
                        (cons 'r (cons 'e empty))))

;; COPIED THE SOURCE FROM SOME KOREAN GUY! 
;; LESSONS LEARNED: NONE!
;; EXCEPT:
;; WRITE THE MOTHERFUCKING CONTRACT ABOVE ANYTHING YOU DEFINE!
;; DONT BE A PUSSY AND DEFINE AUXILIARY FUNCTIONS! FUCK YOU!