;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |19|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;  ---------------------------
;;          Section 19
;;     ABSTRACTING DESIGNS
;;  Similarities in Definitions
;; -----------------------------

;; Repetitions are bad, avoid them.
;; DRY, Refactoring
;; Factoring out similarities aka code patterns

;; Combining 2 functions into one = Functional Abstraction

;; 19.1.1. and 1.2. Im too lazy for, evaluation by hand

;; 1.2 in short : 
;; we can create a function which is dependant on input, 
;; then we can create other functions with that
;; first function. i.e.
;; a function which accepts some kind of conditional operator and
;; a list of values and some value
;; you can create a bunch of functions that iterates through the list
;; and filters out elements depending on the conditional you provide

;; 1.3. is hand evaluation as well. I'm really not willing to do it.

;; -------------------------
;;    Exercise 19.1.4.
;; -------------------------

(define (filter1 predicate alon t)
  (cond
    [(empty? alon) empty]
    [else (cond
          [(predicate (first alon) t)
          (cons (first alon) (filter1 predicate (rest alon) t))]
          [else (filter1 predicate (rest alon) t)])]))
;; Show how to use filter to define functions that are equivalent to 
;; below and above
;;
;;
(define (above1 lon x)
  (local ((define (predicate a)
            (> a x)))
    (filter predicate lon)))

(define (below1 lon x)
  (local ((define (predicate a)
            (< a x)))
  (filter predicate lon)))

;(check-expect (above1 (list 1 2 3 4 5) 3) (list 4 5))
;(check-expect (below1 (list 1 2 3 4 5) 3) (list 1 2))


;; -------------------------
;;    Exercise 19.1.5.
;; -------------------------

;; original functions:
;; mini : nelon  ->  number
;; to determine the smallest number
;; on alon
;(define (mini alon)
;  (cond
;    [(empty? (rest alon)) (first alon)]
;    [else (cond
;	    [(< (first alon) 
;		(mini (rest alon)))
;	     (first alon)]
;	    [else
;	     (mini (rest alon))])]))
;     	
;
;;; maxi : nelon  ->  number
;;; to determine the largest number
;;; on alon
;(define (maxi alon)
;  (cond
;    [(empty? (rest alon)) (first alon)]
;    [else (cond
;	    [(> (first alon)
;		(maxi (rest alon)))
;	     (first alon)]
;	    [else
;	     (maxi (rest alon))])]))
	

;; Task: Abstracting 2 functions above into a single function. 
;; maxi / mini : nelon -> number
;; to determine smallest/largest number on alon
;; consumes non-empty list of numbers and greater than for max
;; and less than for min operator
(define (minormax nelon op)
  (cond
    [(empty? (rest nelon)) (first nelon)]
    [else (cond
            [(op (first nelon)
                (minormax (rest nelon) op))
             (first nelon)]
            [else
             (minormax (rest nelon) op)])]))

;; Testing on lists
(define list1 (list 3 7 6 2 9 8))
(define list2 (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
(define list3 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

; (check-expect (minormax list1 >) 9)
; (check-expect (minormax list2 >) 20)
; (check-expect (minormax list3 >) 20)
; (check-expect (minormax list1 <) 2)
; (check-expect (minormax list2 <) 1)
; (check-expect (minormax list3 <) 1)


;; Improve the abstracted function. Fist introduce a local name for the result of
;; natural recursion.

(define (minormax2 nelon op)
  (cond
    [(empty? (rest nelon)) (first nelon)]
    [else (local ((define first_item (first nelon))
                  (define rest_list (minormax2 (rest nelon) op)))
          (cond
            [(op first_item rest_list) first_item]
            [else rest_list]))]))

; (check-expect (minormax2 list1 >) 9)
; (check-expect (minormax2 list2 >) 20)
; (check-expect (minormax2 list3 >) 20)
; (check-expect (minormax2 list1 <) 2)
; (check-expect (minormax2 list2 <) 1)
; (check-expect (minormax2 list3 <) 1)

;; Then introduce a local auxiliary function that picks the "interesting" one
;; of two numbers. Test mini1 and maxi1 with the same inputs again.

; (define (minormax3 nelon op)
;   (cond
;     [(empty? (rest nelon)) (first nelon)]
;     [else (local ((define ...) ...))]))
; 
    ;; TO BE CONTINUED .... OR COPIED FROM SOMEONE ELSE
    ;; NOT SURE THAT I UNDERSTAND WHAT IS MEANT WITH THE TWO NUMBERS

; (check-expect (minormax3 list1 >) 9)
; (check-expect (minormax3 list2 >) 20)
; (check-expect (minormax3 list3 >) 20)
; (check-expect (minormax3 list1 <) 2)
; (check-expect (minormax3 list2 <) 1)
; (check-expect (minormax3 list3 <) 1)

;; -------------------------
;;    Exercise 19.1.6.
;; -------------------------

; ; sort : list-of-numbers  ->  list-of-numbers
; ; to construct a list with all items from alon in descending order
; (define (sort1 alon)
;  (local ((define (sort1 alon)
; 	    (cond
; 	      [(empty? alon) empty]
; 	      [else (insert (first alon) (sort1 (rest alon)))]))
; 	  (define (insert an alon)
; 	    (cond
; 	      [(empty? alon) (list an)]
; 	      [else (cond
; 		      [(> an (first alon)) (cons an alon)]
; 		      [else (cons (first alon) (insert an (rest alon)))])])))
;    (sort1 alon)))
; (sort1 (list 3 5 2 1 4))

;; Define an abstract version of sort that consumes the comparison 
;; operation in addition to the list of numbers. Use the abstract 
;; version to sort (list 2 3 1 5 4) in ascending and descending order.  


;; absort : alon op -> list-of-numbers
;; to compute a sorted list of numbers in ascending or descending order,
;; depending on input of comparison operation - > descending, < ascending
(define (absort alon op)
  (local ((define (absort alon op)
          (cond
             [(empty? alon) empty]
             [else 
               (local ((define first_item (first alon))
                       (define sort_rest (absort (rest alon) op)))
                       (insert first_item sort_rest op))]))
          (define (insert an alon op)
            (cond
              [(empty? alon) (list an)]
              [else (local ((define first_item (first alon))
                            (define insert_rest (insert an (rest alon) op)))
                           (cond
                             [(op an first_item) (cons an alon)]
                             [else (cons first_item insert_rest)]))])))
         (absort alon op)))
; (absort (list 3 5 2 1 4) >)
; (check-expect (absort (list 2 3 1 5 4) >) (list 5 4 3 2 1))
; (check-expect (absort (list 2 3 1 5 4) <) (list 1 2 3 4 5))

;;  19.2. Similarities in data definition

(define-struct ir (name price))

(define (below-irl aloir t)
  (filter1 less-ir? aloir t))

(define (less-ir? ir t)
  (< (ir-price ir) t))


;; find : loIR t ->  boolean
;; to determine whether t is in a list of inventory records
(define (find1 loIR t)
  (cons? (filter1 eq-ir? loIR t)))

;; eq-ir? : IR symbol -> boolean
;; to compare inventory record with a symbol
(define (eq-ir? ir p)
  (symbol=? (ir-name ir) p))

;; -------------------------
;;    Exercise 19.2.1.
;; -------------------------

;; How to evaluate some values or sth D: 

;; 1.
(below-irl (list (make-ir 'doll 8) (make-ir 'troll 12)) 10)

;; 2.
(find1 (list (make-ir 'doll 8) (make-ir 'troll 12)) 'doll)

;; It will give you an error ir you pass arguments in different order
;; so you have to swap the lists with reference item

;; POLYMORPHIC aka GENERIC FUNCTIONS
;; to write contracts we need PARAMETRIC DATA DEFINITIONS                                                 
;; i.e.

;; a list of ITEM is:
;; 1. empty, or
;; 2. (cons s l), WHERE:
;;       a. s is an ITEM
;;       b. l is a list of ITEM.

;; the token ITEM is a TYPE VARIABLE that stands for any arbitrary 
;; collection of Scheme data. To make language of contracts more concise,
;; we introduce here additional abbreviation:
;; (listof ITEM) i.e. (listof number)
;; TA-DA!

;; In function contracts we would say for an example that function works on all lists:
;; length : (listof X) -> number
; (define (length alon)
;   (cond
;     [(empty? alon) 0]
;     [else (+ (length (rset alon)) 1)]))

;; -------------------------
;;    Exercise 19.2.2.
;; -------------------------
;;  Use the abstracted version of sort from 19.1.6 to sort a list of IRs in ascending and
;;  descending order

(define listIR (list (make-ir 'Zoe 5) (make-ir 'Coach 2) (make-ir 'Steve 3) (make-ir 'Luis 1) (make-ir 'Sven 4)))

(define (less-ir2? ir1 ir2)
  (< (ir-price ir1) (ir-price ir2)))

; (absort listIR less-ir2?)

;; -------------------------
;;    Exercise 19.2.3.
;; -------------------------

;; Here is a structure definition for pairs:
 (define-struct pair (left right))

;; and its parametric data definition
;; a (pair X Y) is a structure (make-pair l r), where
;; l is X and r is Y

;; x and y can be anything: numbers, booleans, symbols ...
;; by combining list definition with our pair definition we get:
;; (listof (pair x y))
;;
;;
;; Develop a function lefts, which consumes a list of (pair X Y) and produces a 
;; corresponding list of X's, e.g. it extracts the left part of each pair

;; lefts : (listof (pair x y)) -> (listof x)
(define (lefts pairs)
  (cond
    [(empty? pairs) empty]
    [else
      (local ((define lefty (pair-left (first pairs)))
              (define rest_pairs (lefts (rest pairs))))
             (cons lefty rest_pairs))]))

(define pairlist1 (list (make-pair 'Romeo 'Juliet) (make-pair 'Bonnie 'Claid) (make-pair 'Julius 'Cleopatra) (make-pair 'Me 'You)))

; (lefts pairlist1)

;; -------------------------
;;    Exercise 19.2.4.
;; -------------------------

;; Here is a parametric definition of NON-EMPTY lists:
;; A (non-empty-listof ITEM) is either:
;; 1. (cons s empty) or
;; 2. (cons s l), WHERE l is a (non-empty-listof ITEM) and s is always an item


;; Develop a function last which consumes a (non-empty-listof ITEM) and produces the last item in the list

;; lastitem : (nelof ITEM) -> ITEM 
(define (lastitem nelof)
  (cond
    [(empty? (rest nelof)) (first nelof)]
    [else (lastitem (rest nelof))]))
;(check-expect (lastitem pairlist1) (make-pair 'Me 'You))
