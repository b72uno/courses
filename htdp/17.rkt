;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |17|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; -------------------------
;;         SECTION 17
;;   Processing Two Complex
;;      Pieces of Data
;; -------------------------
;;

;; Case 1: *******************

;; replace-eol-with : list-of-numbers list-of-numbers -> list-of-numbers
;; to construct a new list by replacing empty in alon1 with alon2
(define (replace-eol-with alon1 alon2) 
  (cond
    [(empty? alon1) alon2]
    [else (cons (first alon1) (replace-eol-with (rest alon1) alon2))]))

;; examples:

;; (replace-eol-with empty L) -> L
;; (replace-eol-with (cons 1 empty) L) -> (cons 1 L)
;; (replace-eol-with (cons 2 (cons 1 empty)) L) -> (cons 2 (cons 1 L))

;; L stands for any list of numbers in this case

;; -------------------------
;;    Exercise 17.1.1.
;; -------------------------

;; our-append : alon1 alon2 -> alon
;; to create a clone of Scheme's append function
;; using previously developed replace-eol-with
(define (our-append alon1 alon2 alon3)
  (replace-eol-with (replace-eol-with alon1 alon2) alon3))

; (check-expect (our-append (list 'a) (list 'b 'c) (list 'd 'e 'f)) (list 'a 'b 'c 'd 'e 'f))

;; -------------------------
;;    Exercise 17.1.2.
;; -------------------------

;; cross: alos alon -> alop
;; to consume a list of symbols and a list of numbers
;; and produce a list with all possible pairs of symbols and numbers
(define (cross alos alon)
  (cond
    [(empty? alos) empty]
    [else (append (cross-out (first alos) alon) 
                  (cross (rest alos) alon))]))

(define (cross-out atom alist)
  (cond
    [(empty? alist) empty]
    [else (append (list 
                   (list atom (first alist)))
                   (cross-out atom (rest alist)))]))
  
;(check-expect (cross '(a b c) '(1 2)) (list (list 'a 1) (list 'a 2) (list 'b 1) (list 'b 2) (list 'c 1) (list 'c 2)))




;; Case 2: *******************

;; hours->wages : list-of-numbers list-of-numbers -> list-of-numbers
;; to construct a new list by multiplying the corresponding items on 
;; alon 1 and alon2
;; ASSUMPTION: the two lists are of equal length
; (define (hours->wages alon1 alon2) ...)

;; examples:
;; (hours->wages empty empty) -> empty
;; (hours->wages (cons 5.65 empty) (cons 40 empty))
;; -> (cons 226.0 empty)
;; (hours->wages (cons 5.65 (cons 8.75 empty))
;;               (cons 40.0 (cons 30.0 empty))
;; -> (cons 226.0 (cons 262.5 empty))

(define (hours->wages alon1 alon2)
  (cond
    ((empty? alon1) empty)
    (else
     (cons (weekly-wage (first alon1) (first alon2))
     (hours->wages (rest alon1) (rest alon2))))))

;; weekly-wage : number number -> number
;; to compute weekly wage by multiplying 2 numbers
(define (weekly-wage payrate hours)
  (* payrate hours))

;(check-expect (hours->wages (cons 5.65 empty) (cons 40 empty)) (cons 226.0 empty))

;; -------------------------
;;    Exercise 17.2.1.
;; -------------------------

(define-struct employee (name ssn payrate))
;; Employee is a structure
;; (make-employee n s p)
;; where n is a symbol s and p are numbers

(define-struct work (name hours))
;; Work is a structure
;; (make-work n h)
;; where n is a symbol and h is a number

(define-struct wage (name wage))
;; Wage is a structure
;; (make-wage n w)
;; where n is a symbol and w is a number

;; Task: modify the function hours->wages so it
;; works with the structures above.

;; hours->wages : employee work -> list-of-wages
(define (hoursToWages employee work)  
  (cond
   [(empty? employee) empty]
   [else (cons
          (weeklyWage (first employee) (first work))
          (hoursToWages (rest employee) (rest work)))]))

;; weeklyWage : employee work -> wage
;; consumes employee and work structures to compute and 
;; output a wage structure
(define (weeklyWage employee work)
  (make-wage (employee-name employee) (* (employee-payrate employee)
                                         (work-hours work))))

;; tests:
;(define employeeList (list (make-employee 'Paul 123456 65.0)
;                           (make-employee 'Jill 654321 55.0)))
;(define workRecords (list (make-work 'Paul 135)
;                          (make-work 'Jill 120)))
;(define expectedWage (list (make-wage 'Paul 8775)
;                           (make-wage 'Jill 6600)))
;
;(check-expect (hoursToWages employeeList workRecords) expectedWage)
              

;; -------------------------
;;    Exercise 17.2.2.
;; -------------------------

(define-struct phone-record (name number))
;; a phone-record is a structure
;; (make-phone-record n nm)
;; where n is a symbol and nm is a number

;; zip : lon lopn -> lopr 
;; to consume a list-of-names and a list-of-phone-numbers
;; and produce a list-of-phone-records. lon is a list of symbols
;; names lopn is a list of numbers and lopr is a list of structures
;; ASSUMPTION: again, we assume, that both lists are of equal length.
(define (zip lon lopn)
  (cond
    [(empty? lon) empty]
    [else (cons (make-phone-record (first lon) (first lopn))
                (zip (rest lon) (rest lopn)))]))

;(check-expect (zip (list 'Kyle 'Joanne) (list 123456 654321))
;              (list (make-phone-record 'Kyle 123456)
;                    (make-phone-record 'Joanne 654321)))




;; Case 3: *******************  

;; list-pick  : list-of-symbols N[>=1] -> symbol
;; to determine the nth symbol from alos, counting from 1;
;; signals an error if there is no nth item
;; (define (list-pick alos n) ...)

;; RECALL:
;; A naturan number [>= 1] (N[>=1]) is either:
;; 1.   1 or
;; 2. (add1 n) if n is a N[>=1].

;; A list of symbols is either:
;; 1. empty or
;; 2. (cons s los) where n is a symbol and
;; los is a list of symbols

;; Examples:

;; (list-pick empty 1)
;; expected:
;; (error 'list-pick "...")

;; (list-pick (cons 'a empty) 1)
;; expected:
;; 'a

;; (list-pick empty 3)
;; expected:
;; (error 'list-pick "...")

;; (list-pick (cons 'a empty) 3)
;; expected:
;; (error 'list-pick "...")

;;(define (list-pick alos n)
;;  (cond
;;    [(and (= n 1) (empty? alos)) ...]
;;    [(and (> n 1) (empty? alos)) ... (sub1 n) ...]
;;    [(and (= n 1) (cons? alos)) ... (first alos) 
;;                                ... (rest alos) ...]
;;    [(and (> n 1) (cons? alos)) ... (sub1 n) 
;;                                ... (first alos) 
;;                                ... (rest alos) ...]))


;; There are three possible recursions:
;; 1. (list-pick (rest alos) (sub1 n))
;; 2. (list-pick alos (sub1 n))
;; 3. (list-pick (rest alos) n)


;; list-pick : list-of-symbols N[>=1] -> symbol
;; to determine the nth symbol from alos, counting from 1;
;; signals an error if there is no nth item
(define (list-pick alos n)
  (cond
    [(and (= n 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (> n 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (= n 1) (cons? alos)) (first alos)]
    [(and (> n 1) (cons? alos)) (list-pick (rest alos) (sub1 n))]))



;; -------------------------
;;    Exercise 17.3.1.
;; -------------------------


;; list-pick0 : list-of-symbols N[>=0] -> symbol
;; to determine the nth symbol from alos, counting from 0;
;; signals an error if there is no nth item
(define (list-pick0 alos n)
  (cond
    [(and (= (add1 n) 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (> (add1 n) 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (= (add1 n) 1) (cons? alos)) (first alos)]
    [(and (> (add1 n) 1) (cons? alos)) (list-pick0 (rest alos) (sub1 n))]))


;(check-expect (list-pick0 (list 'a 'b 'c 'd) 3) 'd)
;(check-expect (list-pick0 (list 'a 'b 'c 'd) 0) 'a)



;; -------------------------------
;;   17.4 Function Simplification
;; -------------------------------

;; We can simplify list-pick by applying De Morgans Law of distribution
;; (or (and cond1 cond2) (and cond3 cond2)) = (and (or cond1 cond3) cond2)

;; so we could 2nd and 3rd cond to simplify it to:
;; (and (or (= n 1) (> n 1)) (empty? alos)...) which further simplifies to
;; (and true (empty? alos)) and since if alos isnt empty, it is going
;; to be cons, we can ditch the checking for that, too:
;;(define (list-pick n alos)
;;  (cond
;;    [(empty? alos) (error 'list-pick "list too short")]
;;    [(= n 1) (first alos)]
;;    [(> n 1) (list-pick (rest alos) (sub1 n))]))


;; -------------------------
;;    Exercise 17.4.1.
;; -------------------------

;; I'm not sure I get the task on hand here.
;; As far as I can tell, there is no way to simplify
;; the original replace-eol-with function. And I dont see
;; how, following anything we did in section 17.2 would
;; change the way the function is structured, either.

;; -------------------------
;;    Exercise 17.4.2.
;; -------------------------

;; We can simplify list-pick0 just the same way we did with list-pick
(define (list-pick02 alos n)
  (cond
    [(empty? alos) (error 'list-pick "list too short")]
    [(= (add1 n) 1) (first alos)]
    [(> (add1 n) 1) (list-pick02 (rest alos) (sub1 n))]))
;(check-expect (list-pick02 (list 'a 'b 'c 'd) 3) 'd)
;(check-expect (list-pick02 (list 'a 'b 'c 'd) 0) 'a)




;; -------------------------------
;; 17.5 and 6 Designing Functions 
;; that Consume Two Complex Inputs
;; -------------------------------


;; -------------------------
;;    Exercise 17.6.1.
;; -------------------------

;; merge : alon alon -> alon
;; to merge 2 sorted lists of numbers
;; a number occurs in the output as many times
;; as it occurs on the two input lists together
(define (merge alon1 alon2)
  (cond
    [(empty? alon1) alon2]
    [(empty? alon2) alon1]
    [(>= (first alon1) (first alon2))
     (cons (first alon2) (merge alon1 (rest alon2)))]
    [else (cons (first alon1) (merge (rest alon1) alon2))]))

;(check-expect (merge (list 1 3 5 7 9) (list 0 2 4 6 8)) (list 0 1 2 3 4 5 6 7 8 9))
;(check-expect (merge (list 1 8 8 11 12) (list 2 3 4 8 13 14)) (list 1 2 3 4 8 8 8 11 12 13 14))


;; -------------------------
;;    Exercise 17.6.2.
;; -------------------------
;; Develop a version of the Hangman game of section 6.7. for words of arbitrary length...

;; A word is either:
;; 1. empty
;; 2. (cons l alos) where
;;     l is a letter and alos is a word

;; A letter is either:
;; 1. empty
;; 2. any of symbols 'a trough 'z + '_

;; A status word is either:
;; 1. empty
;; 2. (cons sl sw) where
;;    sl is a letter and sw is a word


;; reveal-list : chosen-word status-word letter -> status-word
;; ye ye not quite according to data definitions. but its working! for now :D
(define (reveal-list cw sw l)
  (cond
    [(empty? cw) empty]
    [(symbol=? (first cw) (first sw)) 
     (cons (first sw) (reveal-list (rest cw) (rest sw) l))]
    [(and (symbol=? (first sw) '_) (symbol=? (first cw) l)) 
     (cons l (reveal-list (rest cw) (rest sw) l))]
    [else (cons '_ (reveal-list (rest cw) (rest sw) l))]))

;(check-expect (reveal-list (list 't 'e 'a) (list '_ 'e '_) 'u) (list '_ 'e '_))
;(check-expect (reveal-list (list 'a 'l 'e) (list 'a '_ '_) 'e) (list 'a '_ 'e))
;(check-expect (reveal-list (list 'a 'l 'l) (list '_ '_ '_) 'l) (list '_ 'l 'l))

;; Dont have my own functions from hangman game, dunno where I left them, :D
;; borrowing from another source.

;; draw-next-part from ex 6.7.1
;(define (draw-next-part part)
;  (cond
;    [(symbol=? part 'head)
;     (draw-circle (make-posn 100 50) 10 'black)]
;    [(symbol=? part 'body)
;     (draw-solid-line (make-posn 100 60) (make-posn 100 130) 'black)]
;    [(symbol=? part 'right-arm)
;     (draw-solid-line (make-posn 100 75) (make-posn 160 65) 'black)]
;    [(symbol=? part 'left-arm)
;     (draw-solid-line (make-posn 100 75) (make-posn 40 65) 'black)]
;    [(symbol=? part 'right-leg)
;     (draw-solid-line (make-posn 100 130) (make-posn 165 160) 'black)]
;    [(symbol=? part 'left-leg)
;     (draw-solid-line (make-posn 100 130) (make-posn 35 160) 'black)]
;    [(symbol=? part 'noose)
;     (and
;      (draw-solid-line (make-posn 0 10) (make-posn 100 10) 'black)
;      (draw-solid-line (make-posn 100 10) (make-posn 100 30) 'black)
;      (draw-circle (make-posn 120 50) 30 'red)
;      (draw-solid-line (make-posn 115 35) (make-posn 125 45))
;      (draw-solid-line (make-posn 125 35) (make-posn 115 45))
;      (draw-solid-line (make-posn 130 40) (make-posn 140 50))
;      (draw-solid-line (make-posn 140 40) (make-posn 130 50)))]
;    [else false]))

;; test
;; (and (start 200 300) (hangman-list reveal-list draw-next-part))


;; -------------------------
;;    Exercise 17.6.3.
;; -------------------------

(define-struct punch-card (ssn hours))
;; A punch-card is a structure 
;;    (make-punch-card ssn hours) where
;; ssn and hours is a number

;; DEFINED IN PREVIOUS EXERCISES
;; Employee is a structure
;; (make-employee name ssn payrate)
;; where n is a symbol s and p are numbers

;; A list of employee records is either:
;;  1. empty or
;;  2.(cons e alor) where
;; e is an employee and alor is a list of employee records

;; hours->wages2 : list-of-employee-records list-of-punch-cards -> list-of-wages / error
;; ASSUMES: There is at most one card per employee and employee number

;; first we should sort both the lists by numbers, that way
;; if there is some mismatch, we will throw an error

;; sort-punch-cards : lopc -> lopc
;; to sort a list of punch cards by ssn
(define (sort-punch-cards lopc)
  (cond
    [(empty? lopc) empty]
    [else (insert-punch-card (first lopc) (sort-punch-cards (rest lopc)))]))

;; insert-punch-card : card lopc -> lopc
;; to insert a punch card into a sorted list of punch cards
(define (insert-punch-card card lopc)
  (cond
    [(empty? lopc) (list card)]
    [(<= (punch-card-ssn card) (punch-card-ssn (first lopc)))
     (cons card lopc)]
    [else (cons (first lopc) (insert-punch-card card (rest lopc)))]))

;(check-expect (sort-punch-cards (list (make-punch-card 123 25)
;                                      (make-punch-card 456 33)
;                                      (make-punch-card 111 40)
;                                      (make-punch-card 928 35)))
;              (list (make-punch-card 111 40)
;                    (make-punch-card 123 25)
;                    (make-punch-card 456 33)
;                    (make-punch-card 928 35)))


;; sort-employees : loe -> loe
;; to sort a list of employees by ssn
(define (sort-employees loe)
  (cond
    [(empty? loe) empty]
    [else (insert-employee (first loe) (sort-employees (rest loe)))]))

;; insert-employee : employee loe -> loe
;; to insert an employee into a sorted list of employees by ssn
(define (insert-employee employee loe)
  (cond
    [(empty? loe) (list employee)]
    [(<= (employee-ssn employee) (employee-ssn (first loe)))
     (cons employee loe)]
    [else (cons (first loe) (insert-employee employee (rest loe)))]))

;(check-expect (sort-employees (list (make-employee 'Jim 928 30)
;                                    (make-employee 'Katie 111 65)
;                                    (make-employee 'Mike 456 80)
;                                    (make-employee 'Gabe 123 200)))
;              (list (make-employee 'Katie 111 65)
;                    (make-employee 'Gabe 123 200)
;                    (make-employee 'Mike 456 80)
;                    (make-employee 'Jim 928 30)))

;(define MistakesPunchCards (list (make-punch-card 123 25)
;                                      (make-punch-card 456 33)
;                                      (make-punch-card 111 40)
;                                      (make-punch-card 928 35)))
;
;(define MistakesEmployees (list (make-employee 'Jim 928 30)
;                                    (make-employee 'Katie 111 65)
;                                    (make-employee 'Mike 456 80)
;                                    (make-employee 'Gabe 123 200)))
;
;
;(define MistakesPunchCardsSorted (sort-punch-cards MistakesPunchCards))
;(define MistakesEmployeesSorted (sort-employees MistakesEmployees))

;; Note: Feels like I'm going against DRY principle here. Must be away that is more efficient and with the same
;; functionality that I dont know about yet.

;; hours->wages2 : loe lopc -> loew
;; to consume a list of employees and a list of punch cards and compute list of employee wages
(define (hours->wages2 loe lopc)
  (cond
    ; if both are empty, we are done with loop
    [(and (empty? loe) (empty? lopc)) empty] 
    ; if only one is empty = it got this far, then there must be a mismatch
    [(or (empty? loe) (empty? lopc)) (error 'hours->wages2: "Mismatched list lengths.")]
    ; if there are different ssn-s, ask to sort the lists and try again.
    [(not (= (employee-ssn (first loe)) (punch-card-ssn (first lopc)))) 
     (error 'hours->wages2: "Mismatched SSNs. Please sort both lists by SSNs and try again.")]
    ; else compute the weekly wage
    [else (cons (make-wage (employee-name (first loe)) (* (employee-payrate (first loe))
                                                          (punch-card-hours (first lopc))))
                (hours->wages2 (rest loe) (rest lopc)))]))


;(check-expect (hours->wages2 MistakesEmployeesSorted MistakesPunchCardsSorted)
;              (list (make-wage 'Katie 2600)
;                    (make-wage 'Gabe 5000)
;                    (make-wage 'Mike 2640)
;                    (make-wage 'Jim 1050)))
;(hours->wages2 MistakesEmployees empty) ; expected: error, mismatched list lengths
;(hours->wages2 MistakesEmployees MistakesPunchCards) ; expected: error, asks to sort lists


;; -------------------------
;;    Exercise 17.6.4.
;; -------------------------

;; value : loc lov -> number
;; to produce total value by combining a list of coeficients 
;; and a list of values. 
;; ASSUMES: lists are of equal length.
(define (value loc lov)
  (cond
    [(empty? loc) 0]
    [else (+ (* (first loc) (first lov)) 
             (value (rest loc)(rest lov)))]))

;(check-expect (value (list 5 17 3) (list 10 1 2)) 73)


;; -------------------------
;;    Exercise 17.6.5.
;; -------------------------

;; gift-pick : list-of-names -> list-of-names
;; to pick a 'random' non-identity arangement of names
;(define (gift-pack names)
;  (random-pick
;   (non-same names (arrangements names))))

;; Auxiliary stuff:

;; List of names:
(define sisters (list 'Louise 'Jane 'Laura 'Dana 'Mary))

;; Arrangements function from section 14.2.:
;; arangements : list-of-names -> list-of-lists-of-names :D
(define (arrangements names)
  (cond 
    [(empty? names) (cons empty empty)]
    [else (combine-all/with-all-names (first names) 
                             (arrangements (rest names)))]))

;; combine-with-rest : name list-of-names -> list-of-names
(define (combine-all/with-all-names name lon)
  (cond
    [(empty? lon) empty]
    [else (append (combine-name/with-a-name name (first lon))
                (combine-all/with-all-names name (rest lon)))]))

;; combine-name/with-a-name : name lon -> lon
(define (combine-name/with-a-name name lon)
  (cond
    [(empty? lon) (list (cons name empty))]
    [else (cons (append (list name (first lon))(rest lon))
                (combine-first/with-all-names 
                 (first lon)
                 (combine-name/with-a-name name (rest lon))))]))

;; combine-first/with-all-names : name lon -> lon
(define (combine-first/with-all-names firstn lon)
  (cond
    [(empty? lon) empty]
    [else (cons (cons firstn (first lon))
                (combine-first/with-all-names firstn (rest lon)))]))
    
;; (arrangements sisters)
;; End of Arrangements

;; non-same : list-of-names list-of-list-of-names -> list-of-list-of-names
(define (non-same lon lolon) 
  (cond
    [(empty? lolon) empty]
    [else (filter list? (cons (replace-same lon (first lolon))
                              (non-same lon (rest lolon))))]))

;; replace-same : lon1 lon2 -> lon2 / false
;; consumes 2 lists of numbers, compares them, returns
;; second list if they are completely different,
;; returns false if they agree on some position
(define (replace-same lon1 lon2)
  (cond
    [(compare-lists lon1 lon2) lon2]
    [else false]))

;; compare-lists : lon1 lon2 -> boolean
;; checks whether the lists are different at all positions
;; if so, outputs true, if not outputs false
;; ASSUMES: lists are equal lengths
(define (compare-lists lon1 lon2)
  (cond
    [(empty? lon2) true]
    [(and (not (symbol=? (first lon1) (first lon2)))
               (compare-lists (rest lon1) (rest lon2)))
     true]
    [else false]))

;; test
;; (non-same sisters (arrangements sisters))

;; random-pick : lolon -> lon
;; consumes a list of lists of names, randomly picks one and
;; outputs it.

;; Auxiliary stuff first:

;; count-list : loi -> number
;; consumes a list of items and outputs the 
;; number of items in the list
(define (count-list loi)
  (cond
    [(empty? loi) 0]
    [else (+ 1 (count-list (rest loi)))]))
;; test
;;(count-list (arrangements sisters))
;;(count-list (non-same sisters (arrangements sisters)))

;; pick-nth-item : lolon number -> lon
;; consumes a list of lists of names and a number
;; and returns the nth list from the list
(define (pick-nth-item lolon n)
  (cond
    [(= 0 n) (error 'pick-nth-item "CHANGE N : N > 0")]
    [(empty? lolon) empty]
    [(= 0 (- n 1)) (first lolon)]
    [else (pick-nth-item (rest lolon) (- n 1))]))
;; test
;(define testlist1 (list (list 'a 'b 'c)
;                        (list 'd 'e 'f)
;                        (list 'f 'g 'h)))
;(pick-nth-item testlist1 0 )

;; random-pick : lolon -> lon
(define (random-pick lolon)
  (cond
    [(empty? lolon) empty]
    [else (pick-nth-item (non-same lolon (arrangements lolon))
                         (+ (random 
                         (- 
                         (count-list (non-same lolon (arrangements lolon)))
                         1)) 1)
                         )]))
;; test
;(random-pick sisters)


;; -------------------------
;;    Exercise 17.6.6.
;; -------------------------

;; DNAPrefix : pattern search-string -> boolean
;; to check-whether the pattern is a prefix of the search-string
;; pattern and search-string are both lists of symbols
;; (only 'a 'c 'g and 't occurs in DNA, but we ignore it here)
;; If the pattern is a prefix of the search-string, returns true. else false.

;; Examples:
; (DNAprefix (list 'a 't) (list 'a 't 'c)) -> true
; (DNAprefix (list 'a 't) (list 'a)) -> false
; (DNAprefix (list 'a 't) (list 'a 't)) -> true
; (DNAprefix (list 'a 'c 'g 't) (list 'a 'g)) -> false
; (DNAprefix (list 'a 'a 'c 'c) (list 'a 'c)) -> false

;; DNAprefix : pattern search-string -> boolean
;; to check whether the pattern is a prefix of the search-string
;; ASSUMES: you are not feeding this function an empty initial search-string
(define (DNAprefix pattern search-string)
  (cond
    [(empty? pattern) true]
    [(empty? search-string) false]
    [(symbol=? (first pattern) (first search-string))
     (DNAprefix (rest pattern) (rest search-string))]
    [else false]))

;(check-expect (DNAprefix (list 'a 't) (list 'a 't 'c)) true)
;(check-expect (DNAprefix (list 'a 't) (list 'a)) false)
;(check-expect (DNAprefix (list 'a 't) (list 'a 't)) true)
;(check-expect (DNAprefix (list 'a 'c 'g 't) (list 'a 'g)) false)
;(check-expect (DNAprefix (list 'a 'a 'c 'c) (list 'a 'c)) false)


;; MODIFIED:

;; DNAprefixS : pattern search-string -> boolean / symbol
;; this time we return the first item beyond the pattern in the search-string
;; if the pattern is a proper prefix of the search string
;; if lists are equally long and match, the result is still true
(define (DNAprefixS pattern search-string)
  (cond
    [(empty? pattern)
     (cond
       [(empty? search-string) true]
       [else (first search-string)])]
    [(empty? search-string) false]
    [(symbol=? (first pattern) (first search-string))
     (DNAprefixS (rest pattern) (rest search-string))]
    [else false]))

;(check-expect (DNAprefixS (list 'a 't) (list 'a 't 'c)) 'c)
;(check-expect (DNAprefixS (list 'a 't) (list 'a)) false)
;(check-expect (DNAprefixS (list 'a 't) (list 'a 't)) true)
;(check-expect (DNAprefixS (list 'a 'c 'g 't) (list 'a 'g)) false)
;(check-expect (DNAprefixS (list 'a 'a 'c 'c) (list 'a 'c)) false)



;; -------------------------------
;; 17.7. Evaluating Scheme, Part 2
;; -------------------------------

;; ASSUME: all functions in the definitions window consumes one argument(variable)

;; -------------------------
;;    Exercise 17.7.1.
;; -------------------------

;; Have to data definition of exercise 14.4.1. such that we can represent
;; the application of a user-defined function to expressions such as
;; (f (+ 1 1)) or (* 3 (g 2))

;; Stuff from 14.4.1:

;; Scheme expresions:
;; 1. A number
;; 2. A variable
;; 3. Simple expressions 
;;    a. (make-mul left right)
;;    b. (make-add left right)
;; 4. Nested expressions
;;    a. (make-add (make-add left right) (make-add left right))
;;    b. (make-mul (make-mul left right) right)
;;    etc


;; 1. (make-add 10 -10)
;; 2. (make-add (make-mul 20 3) 33)
;; 3. (make-mul 3.14 (make-mul r r))
;; 4. (make-add (make-mul 9/5 c) 32)
;; 5. (make-add (make-mul 3.14 (make-mul o o)) (make-mul 3.14 (make-mul i i)))

;; Scheme evaluator should be applied only to representations of expressions
;; that do not contain variables. We say such expressions are numeric

;; Extension:
;; ...
;; 5. User defined functions
;; (make-func function-name argument expression)
;; function is a structure, where
;; function-name and argument is a symbol and expression is an expression(3./4.)
;; where one or more of the atomic values may be argument (variable)


;; -------------------------
;;    Exercise 17.7.2.
;; -------------------------

;; Data definition has 3 essential attributes:
;; 1.the function name
;; 2.the parameter name, and
;; 3.the function's body.

;; Therefore function is a structure
;; (make-func function-name argument expression)
;; where function-name and argument are symbols and expression
;; represents function's body

;; Translating definitions into Scheme values:
;; 1. (define (f x) (+ 3 x)) -> (make-func 'f 'x (make-add 3 'x))
;; 2. (define (g x) (+ 3 x)) -> (make-func 'g 'x (make-mul 3 x))
;; 3. (define (h u) (f (* 2 u)) -> (make-func 'h 'u (make-func 'f 'u (make-add 3 (make-mul 2 'u))))
;; 4. (define (i v) (+ (* v v) (* v v))) -> (make-func 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v)))
;; 5. (define (k w) (* (h w) (i w)) -> (make-func 'k 'w
;;                                        (make-mul 
;;                                          (make-func 'h 'w (make-func 'f 'w (make-add 3 (make-mul 2 'w)))
;;                                          (make-func 'i 'w (make-add (make-mul 'w 'w) (make-mul 'w 'w))))
;;                                         ))
;;      

(define-struct func (name variable body))
                                                                  
;; -------------------------
;;    Exercise 17.7.3.
;; -------------------------

;; for the sake of simplicity, I wont define alternative expressions from 14.4.1. such
;; as (make-add ...) and (make-mul ...)

;; evaluate-with-one-def : expression function-def -> value / error
;; to consume a representation of a Scheme expression (num / variable / expression) and
;; a definition of one function. If encounters variable, which is not the same as in function def
;; then signals an error, otherwise:
;;  1. evaluates the argument
;;  2. substitues the value of the argument for the function parameter in the functions body
;;  3. evaluates the new expression via recursion

;; Sketch: (evaluate-with-one-def (subst ... ... ...) a-fun-def)

;; Note: I have no idea how the sketch above is achievable. I just dont see
;; the "new" way of recursion. I'll just do what I can scramble together
;; from my interpretation and as they have stated I'm to learn more about
;; this way of recursion in section 25++ (chapter V++).

;; Getting eval, subst, numeric funcs from 14.4. :
(define-struct mul (left right))
(define-struct add (left right))

;; numeric : expr -> boolean
(define (numeric? expr)
  (cond
    [(symbol? expr) false]
    [(string? expr) false]
    [(number? expr) true]
    [(mul? expr) (and (numeric? (mul-left expr))
                      (numeric? (mul-right expr)))]
    [(add? expr) (and (numeric? (add-right expr))
                      (numeric? (add-left expr)))]
    ;; adding for functions
    [(func? expr) (numeric? (func-body func))]
    [else (error "All your numeric are belongs to us")]))

;; evaluate-expression : scheme-expression -> error / number
(define (evaluate-expression expr)
  (cond
    [(number? expr) expr]
    [(numeric? expr) expr]
    [else (cond
         [(mul? expr)
          (* (evaluate-expression (mul-left expr))
             (evaluate-expression (mul-right expr)))]
         [(add? expr)
          (+ (evaluate-expression (add-left expr)
                                  (add-right expr)))]
         ;; adding for functions
         [(func? expr)
          (evaluate-expression (func-body expr))]
         [else (error 'eval "All your eval are belongs to us")])]))


;; subst : variable number expression -> expression
(define (subst var num expr)
  (cond
    [(equal? var expr) num]
    [(add? expr) (make-add (subst var num (add-left expr))
                           (subst var num (add-right expr)))]
    [(mul? expr) (make-mul (subst var num (mul-left expr))
                           (subst var num (mul-right expr)))]
    ;; add for functions
    [(func? expr) (make-func (func-name expr)
                             (func-variable expr)
                             (subst var num (func-body expr)))]
    [(symbol? expr) expr]
    [(numeric? expr) expr]
    [else (error 'subst "All your subst base are belongs to us")]))
               
;; End of stuff from 14.4., now to the main task:


;; Example: 
;; (evaluate-with-one-def 3 (make-mul 3 (f 2)) (define f (make-func 'f 'x (make-add 2 'x))))
;; this should:
;;  1. evaluate the argument (2), 
;;  2. substitute the value of arg for function param in functions body
;;  3. evaluate the new expr via recursion (eval (make-mul 3 (2nd step))

;; keeping this thing around, maybe I'll get it
;; Sketch: (evaluate-with-one-def (subst ... ... ...) a-fun-def)

;; evaluate-with-one-def : function-definition scheme-expression -> error / number
;; to evaluate a function with one definition
;(define (evaluate-with-one-def expr funcdef)
;  (cond
;    [(numeric? expr) (evaluate-expression expr)]
;    [(not (numeric? expr)) (evaluate-with-one-def 
;      (subst (func-variable expr) (func-variable funcdef) expr) funcdef)]
;    [else (error 'evaluate-with-one-def "All your eval-one-def base are belong to us")]))

;; lets see (evaluate-with-one-def (make-add (f 2) 3) (define f (make-func 'f 'x (make-mul 'x 3))
;; 1st evaluate argument:
;; which can be a number -> number,
;; a symbol -> error , an expression -> number
;; another function -> recursion should happen


;; K I GIVE UP. I see no way I can link / compare the function name in the representation
;; of expression with the function definition itself. If there was a way,
;; the rest would be no problem, I think. :) Moving on for now then...


;; UPDATE!: Having read the beginning of section 18, I realised
;; I can define it like this (define (f x) (make-func 'f 'x (make-mul 'x 5))
;; Yet I still have no idea, how could I access the variable passed in (f x),
;; the variable being the x, a number or whatever else is passed.


;; -------------------------------
;;   17.8 Equality and Testing
;; -------------------------------

;; list=? : list-of-numbers list-of-numbers -> boolean
;; to determine wheter 2 lists contain the same numbers
;; in the same order
(define (list=? a-list another-list)
  (cond
    [(and (empty? a-list) (empty? another-list)) true]
    [(and (cons? a-list) (empty? another-list)) false]
    [(and (empty? a-list) (cons? another-list)) false]
    [(and (cons? a-list) (cons? another-list)) 
     (and (= (first a-list)
          (first another-list))
          (list=? (rest a-list) (rest another-list)))]
    [else false]))

;; a better version:
(define (list1=? a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [(cons? a-list)
     (and (cons? another-list)
          (and (= (first a-list) (first another-list))
               (list1=? (rest a-list) (rest another-list))))]
    [else false]))

;; -------------------------
;;    Exercise 17.8.1.
;; -------------------------
;; Test both functions above

;(check-expect (list=? empty empty) true)
;(check-expect 
;  (list=? empty (cons 1 empty)) false)
;(check-expect 
;  (list=? (cons 1 empty) empty) false)
;(check-expect (list=? (cons 1 (cons 2 (cons 3 empty))) 
;              (cons 1 (cons 2 (cons 3 empty)))) true)
;(check-expect
;  (list=? (cons 1 (cons 2 (cons 3 empty))) 
;          (cons 1 (cons 3 empty))) false)
;(check-expect (list1=? empty empty) true)
;(check-expect 
;  (list1=? empty (cons 1 empty)) false)
;(check-expect 
;  (list1=? (cons 1 empty) empty) false)
;(check-expect (list=? (cons 1 (cons 2 (cons 3 empty))) 
;              (cons 1 (cons 2 (cons 3 empty)))) true)
;(check-expect
;  (list1=? (cons 1 (cons 2 (cons 3 empty))) 
;          (cons 1 (cons 3 empty))) false)

;; -------------------------
;;    Exercise 17.8.2.
;; -------------------------
;; Simplify the first version of list
;; list2=? : list list -> boolean
(define (list2=? a-list another-list)
  (cond
    [(or (and (cons? a-list) (empty? another-list))
         (and (empty? a-list) (cons? another-list))) false]
    [else
     (or (and (empty? a-list) (empty? another-list))
         (and (= (first a-list)
          (first another-list))
          (list2=? (rest a-list) (rest another-list))))]
    ))

;(check-expect (list2=? empty empty) true)
;(check-expect 
;  (list2=? empty (cons 1 empty)) false)
;(check-expect 
;  (list2=? (cons 1 empty) empty) false)
;(check-expect (list=? (cons 1 (cons 2 (cons 3 empty))) 
;              (cons 1 (cons 2 (cons 3 empty)))) true)
;(check-expect
;  (list2=? (cons 1 (cons 2 (cons 3 empty))) 
;          (cons 1 (cons 3 empty))) false)


;; -------------------------
;;    Exercise 17.8.3.
;; -------------------------
;; sym-list=? : list1 list2 -> boolean
;; to determine whether 2 lists of symbols
;; contain the same symbols and in the same order
;; assumes that you feed it list of symbols not list of something else
(define (sym-list=? los1 los2)
  (cond
    [(empty? los1) (empty? los2)]
    [(cons? los1) (and (symbol=? (first los1) (first los2))
                       (sym-list=? (rest los1) (rest los2)))]))
;(check-expect (sym-list=? (list 'a 'b 'c) (list 'a 'b 'c)) true)
;(check-expect (sym-list=? (list 'a 'x 'c) (list 'a 'b 'c)) false)

;; -------------------------
;;    Exercise 17.8.4.
;; -------------------------
;; contains-same-numbers : lon lon -> boolean
;; to determine whether two lists of numbers
;; contain the same numbers regardless of ordering
(define (contains-same-numbers lon1 lon2)
  (cond
    [(empty? lon1) (empty? lon2)]
    [(cons? lon1) 
     (and (cons? lon2)
          (and (= (first (order-asc lon1))
                  (first (order-asc lon2)))
               (contains-same-numbers (rest (order-asc lon1))
                                      (rest (order-asc lon2)))))]))

;; order-asc : lon -> lon
;; to order a list of numbers 
(define (order-asc lon)
  (cond
    [(empty? lon) empty]
    [else (insert-into (first lon) (order-asc (rest lon)))]))
;; auxiliary func
;; insert-into : number lon -> lon
(define (insert-into number lon)
  (cond
    [(empty? lon) (cons number empty)]
    [(< number (first lon)) (append (list number) lon)]
    [else (cons (first lon) (insert-into number (rest lon)))]))


;; tests for first func
;(check-expect (contains-same-numbers (list 1 2 3) (list 3 2 1)) true)

;; -------------------------
;;    Exercise 17.8.5.
;; -------------------------

;; An atom is either:
;; 1. a number
;; 2. a boolean
;; 3. a symbol

;; list-equal? : list1 list2 -> boolean
;; to determine whether 2 lists have the same
;; atoms and in the same order
(define (list-equal? list1 list2)
  (cond
    [(empty? list1) (empty? list2)]
    [(cons? list1)
     (and 
      (cons? list2)
      (cond
        [(number? (first list1))
         (and (number? (first list2)) (= (first list1) (first list2))
              (list-equal? (rest list1) (rest list2)))]
        [(boolean? (first list1))
         (and (boolean? (first list2)) (equal? (first list1) (first list2))
              (list-equal? (rest list1) (rest list2)))]
        [(symbol? (first list1))
         (and (symbol? (first list2)) (equal? (first list1) (first list2))
              (list-equal? (rest list1) (rest list2)))]))]))
;; tests:
;(check-expect (list-equal? (list 'a 'b 2 true 'x 3 false)
;                           (list 'a 'b 3 false 'x 3 true)) false)
;(check-expect (list-equal? (list 'b 'c 4) (list 'c 'b false)) false)
;(check-expect (list-equal? (list true 5 'max) (list true 5 'max)) true)


;; -------------------------
;;    Exercise 17.8.6.
;; -------------------------

;; A web page can be:
;; 1. empty
;; 2. (cons s wp) where
;;    s is a symbol and wp is a web page
;; 3. (cons ewp wp) where both
;;    ewp and wp are web pages

;; +---------------+---------------+
;; |      wp1      |      wp2      |
;; +---------------+---------------+
;; | empty         | emtpy         |
;; | empty         | (cons s wp)   |
;; | empty         | (cons ewp wp) |
;; | (cons s wp)   | empty         |
;; | (cons ewp wp) | empty         |
;; | (cons s wp)   | (cons ewp wp) |
;; | (cons ewp wp) | (cons ewp wp) |
;; | (cons ewp wp) | (cons s wp)   |
;; | (cons s wp)   | (cons s wp)   |
;; +---------------+---------------+

;; web=? : wp1 wp2 -> boolean
;; to determine whether 2 web pages have the same
;; structure and the same symbols in the same order
(define (web=? wp1 wp2)
  (cond
    [(empty? wp1) (empty? wp2)]
    [(symbol? (first wp1))
     (and
      (and (cons? wp2) (symbol? (first wp2)))
      (and (symbol=? (first wp1) (first wp2))
           (web=? (rest wp1) (rest wp2))))]
    [else 
     (and
      (and (cons? wp2) (list? (first wp2)))
      (and (web=? (first wp1) (first wp2))
           (web=? (rest wp1) (rest wp2))))]))
;; test

;; -------------------------
;;    Exercise 17.8.7.-12. 
;; -------------------------

;; Cba, all you have to do there is to rewrite previous functions using "equal?"
