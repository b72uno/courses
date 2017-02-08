;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |22|) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "gui.ss" "teachpack" "htdp")))))
;;  ---------------------------
;;          Section 22
;; -----------------------------

;; 22.1 Functions that produce functions
;; @_@

;(define (f x) first)
;(define (g x) f)
;(define (h x)
;  (cond
;    [(empty? x) f]
;    [(cons? x) g]))

;(define (add x)
 ; (local ((define (x-adder y) (+ x y)))
 ;   x-adder))

;; evaluating to see:
;; (define f (add 5)
;; = (define f (local ((define (x-adder y) (+ 5 y))) x-adder))
;; = (define f (local ((define (x-addery y) (+ 5 y))) x-adder5))
;; = (define (x-addery5 y) (+ 5 y))
;; (define f x-adder5)


;; The last step adds the function x-adder5 ot the collection
;; of our definitions; the evaluation continues with the body of the
;; local expression, x-adder5, which is the name of a function and
;; thus a value. Now f is defined and we can use it:

;; (f 10)
;; = (x-adder5 10)
;; = (+ 5 10)
;; = 15

;; We can write add's contract and purpose statement:
;; add : number -> (number -> number)
;; to create a function that adds x to its input
(define (add x)
  (local ((define (x-adder y) (+ x y)))
    x-adder))


;; 22.2 Designing Abstractions with functions as values

;; Abstracting with local
;; filter : (X Y -> boolean) -> ((listof X) Y -> (listof X)
(define (filter2 rel-op)
  (local ((define (abs-fun alon t)
            (cond
              [(empty? alon) empty]
              [else
               (cond
                 [(rel-op (first alon) t)
                  (cons (first alon)
                        (abs-fun (rest alon) t))]
                 [else 
                  (abs-fun (rest alon) t)])])))
    abs-fun))


;; -------------------------
;;    Exercise 22.2.1.
;; -------------------------

;; Define an abstraction of the functions convertCF and names
;; from section 21.1 using the new recipe fro abstraction

;; convertCF : lon  ->  lon
(define (C->F x)
  (+ x 5))

(define (convertCF alon)
  (cond
    [(empty? alon) empty]
    [else
      (cons (C->F (first alon))
	(convertCF (rest alon)))]))

;; names : loIR  ->  los
(define (IR-name x)
  'LOL)

(define (names aloIR)
  (cond
    [(empty? aloIR) empty]
    [else
      (cons (IR-name (first aloIR))
	(names (rest aloIR)))]))

;; map2 : (X -> Y) -> ((listof X) -> (listof Y))
;; to map a list of items
(define (map2 f)
  (local ((define (mapf alon)
            (cond
              [(empty? alon) empty]
              [else (cons (f (first alon))
                    (mapf (rest alon)))])))
    mapf))
(define CtoF (map2 C->F))
(define LOLlist (map2 IR-name))

;(check-expect (convertCF '(1 2 3 4 5 6)) (CtoF '(1 2 3 4 5 6)))
;(check-expect (names '('a 'b 'c 'd)) (LOLlist '('a 'b 'c 'd)))

;; -------------------------
;;    Exercise 22.2.1.
;; -------------------------

;; Define an abstract version of sort using the new recipe for
;; abstraction (from exercise 19.1.6)

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


;; absort2 : (X Y -> Boolean) -> ((listof X) -> (listof X))
(define (absort2 op)
  (local
    ((define (sort1 alon)
       (cond
         [(empty? alon) empty]
         [else
          (local
            ((define first_item (first alon))
             (define sort_rest (sort1 (rest alon))))
             (insert first_item sort_rest))]))
     (define (insert an alon)
       (cond
         [(empty? alon) (list an)]
         [else
          (local ((define first_item (first alon))
                    (define insert_rest (insert an (rest alon))))
            (cond
              [(op an first_item) (cons an alon)]
              [else (cons first_item insert_rest)]))])))
    sort1))

(define sort-asc (absort2 <))
(define sort-desc (absort2 >))

;(check-expect (absort '(0 5 9 3 8 1) <) (sort-asc '(0 5 9 3 8 1)))
;(check-expect (absort '(0 5 9 3 8 1) >) (sort-desc '(0 5 9 3 8 1)))
 

;; -------------------------
;;    Exercise 22.2.2.
;; -------------------------

;; Define fold using the new recipe for abstraction
;; fold abstracts the following pair of functions:

;; sum : (listof number)  ->  number
;; to compute the sum of alon
(define (sum alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon)
	     (sum (rest alon)))]))
     	
;; product : (listof number)  ->  number
;; to compute the product of alon
(define (product alon)
  (cond
    [(empty? alon) 1]
    [else (* (first alon)
	     (product (rest alon)))]))

;; fold2 : (X Y -> Z) -> ((listof X) -> Y)
(define (foldit op basecase)
  (local
    ((define (foldme alon)
        (cond
          [(empty? alon) basecase]
          [else (op (first alon) (foldme (rest alon)))])))
    foldme))

(define sum1 (foldit + 0))
(define product1 (foldit * 1))

;(check-expect (sum '(1 2 3 4 5)) (sum1 '(1 2 3 4 5)))
;(check-expect (product '(1 2 3 4 5)) (product1 '(1 2 3 4 5)))



;; 22.3 A First Look at Graphical User Interfaces (GUI-s)

;; Functions as first-class values play a central role in the design
;; of graphical user interfaces. The interaction between a program
;; and a casual user is the USER INTERFACE

;;           A gui-item is either:

;;  1. (make-button string (X -> true))

;;  2. (make-text string)

;;  3. (make-choices (listof string)), or

;;  4. (make-message string)

;; The gui.ss operations:

;; create-window : (listof (listof gui-item)) -> true
;; to add ugi-items to the window and to show the window
;; each list of gui-items defines one row of gui items in the window

;; hide-window : X -> true
;; to hide the window

;; make-button : string (event% -> true) -> gui-item
;; to create a button with a label and call-back function

;; make-message : string -> gui-item
;; to create an item that displays message

;; draw-message : gui-item[message%] string -> true
;; to display a message in a message item
;; it erases the current message

;; make-text : string -> gui-item
;; to create an item (with label) that allows users to enter text

;; text-contents : gui-item[text%] -> string
;; to determine the contents of a text field

;; make-choice : (listof string) -> gui-item
;; to create a choice menu that permits users to choose from some
;; string alternatives

;; choice-index : gui-item[choice%] -> num
;; to determine which choice is currently selected in a choice-item
;; the result is the 0-based index in the choice menu


(define a-text-field (make-text "Enter Text:"))
(define a-message (make-message "'Hello World' is a silly program."))

;; echo-message : X -> true
;; to extract the contents of a-text-field and to draw
;; it into a-message
(define (echo-message e)
  (draw-message a-message (text-contents a-text-field)))

;(create-window
; (list (list a-text-field a-message)
;       (list (make-button "Copy Now" echo-message))))

;; Window with a choice menu, a message field and a button

;; start by defining the output and input gui items
(define the-choices '("green" "red" "yellow"))
(define a-choice (make-choice the-choices))
(define a-message2 (make-message (first the-choices)))

;; echo-choice : X -> true
;; to determine the current choice of a choice and
;; to draw the corresponding string into a-message
(define (echo-choice e)
  (draw-message a-message2 (list-ref the-choices
                                    (choice-index a-choice))))

;(create-window
; (list (list a-choice a-message2)
;       (list (make-button "Confirm Choice" echo-choice))))



;; -------------------------
;;    Exercise 22.3.1.
;; -------------------------
;; Modify the following stuff (from figure 63)
;; so that it implements the number
;; guessing gname from exercises 5.1.2, 5.1.3. and
;; 9.5.5.

;; Hurr durr, havent saved the code from those chapters.

;; A GUI for echoing digits as numbers.

(define numbase 10)
(define numcount 3)

;; MVC architecture

;; Model:
;; build-number : (listof digit) -> number
;; to translate a list of digits into a number
;; example: (build-number '(1 2 3)) = 123
(define (build-number x)
  (local ((define (list->number lon k)
            (cond
              [(< k 0) 0]
              [else (+ (* (first lon) (expt 10 k)) (list->number (rest lon) (sub1 k)))])))
    (list->number x (sub1 numcount))))


;; randlist : number number -> (listof number)
(define (randlist n k)
  (cond
    [(<= n 0) empty]
    [else (cons (random (+ k 1)) (randlist (- n 1) k))]))
          
(define num2guess (build-number (randlist numcount numbase)))

;; check-guess : number -> string (Higher/Lower/You got it right!)
(define (check-guess n)
  (cond
    [(> n num2guess) "Lower"]
    [(< n num2guess) "Higher"]
    [(= n num2guess) "You Got It Right!"]
    [else "Take a guess!"]))


;; View:
;; the ten digits as strings
(define DIGITS
  (build-list numbase number->string))

;; a list of three digit choice menus
(define digit-choosers
  (local ((define (builder i) (make-choice DIGITS)))
  (build-list numcount builder)))

;; a message field for saying hello and displaying the number
(define a-msg
  (make-message "Welcome"))

;; Controller:
;; check-call-back : X -> true
;; to get the current choices of digits and convert them
;; to a number, and to draw this number as a string
;; into the message field

(define (check-call-back b)
  (draw-message a-msg
                (check-guess
                 (build-number (map choice-index digit-choosers)))))
;(create-window
; (list
;  (append digit-choosers (list a-msg))
;  (list (make-button "Check Guess" check-call-back))))



;; -------------------------
;;    Exercise 22.3.2.
;; -------------------------
;; Develop a program for looking up phone numbers.
;; The program's GUI should consist of a text field,
;; a message field, and a button. The text field permits users
;; to enter names. The message field should display the number
;; that the model finds or the message "name not found",
;; if the model produces false

;; Generalize the program so that user can also enter a phone number

;; Scheme provides string->symbol and string->number


;; Model
;; build-number : (listof digit) -> number
;; to translate a list of digits into a number
;; example: (build-number '(1 2 3)) = 123
(define-struct pbentry (name number))
(define phonebook (list (make-pbentry 'John 2550352)
                    (make-pbentry "Jane" 0510412)
                    (make-pbentry "Ermahgerd" 1000007)
                    (make-pbentry "Steve" 1333337)
                    (make-pbentry "Bames Jond" 007)
                    (make-pbentry "Agent" 47)))

(define (lookup number)
  (local ((define (chkpbook nbr pbook)
            (cond
              [(empty? pbook) false]
              [(equal? nbr (pbentry-number (first pbook))) (pbentry-name (first pbook))]
              [else (chkpbook number (rest pbook))])))
          (chkpbook number phonebook)))

(define (lookup-num num)
  (cond
    [(not (number? num)) "This aint no number I know of, motherfucker!"]
    [(false? (lookup num)) "No entry found!"]
    [else (lookup num)]))


;; View

(define a-msg2
  (make-message "Numbers, motherfucker! Do you speak it?"))


;; Controller

;; check-call-back2 : X -> true
;; to get the entered number and to check the phonebook
;; for it
(define (check-call-back2 b)
  (draw-message a-msg2 (lookup-num (string->number (text-contents a-text-field)))))

;(create-window
; (list (list a-text-field a-msg2)
;       (list (make-button "Look It Up!" check-call-back2))))
                       

;; User can only look up names by entering numbers. Close enough.
;; I could refactor functions so they accept the other model
;; i.e. vice versa - look up numbers by names, without changing gui.
;; Too bad I'm lazy.


;; -------------------------
;;    Exercise 22.3.3.
;; -------------------------

;; Develop pad->gui.
;; The function consumes a title(string) and a
;; gui-table. It turns the table into a list of gui-items
;; that create-window can consume

;; Here's the data definition for gui-tables:

;; A cell is either:
;; 1. a number,
;; 2. a symbol.

;; A gui-table is a (listof (listof cell)).

;; Here are 2 examples of gui-tables:
;; a virtual phone pad
(define pad
  '((1 2 3)
    (4 5 6)
    (7 8 9)
    (\# 0 *)))
;; a calculator pad
(define pad2
  '((1 2 3 +)
    (4 5 6 -)
    (7 8 9 *)
    (0 = \. /)))

;; The function pad->gui should turn each cell into a button.
;; The resulting list should be prefixed with two messages.
;; The first one displays the title and never changes.
;; The second one displays the last button that the user clicked.



;; Model:

;; pad->gui : string (listof (listof (listof X))) -> gui?
(define (pad->gui title pad)
  (local
    ((define (nonompad title food)
      (cond
        [(empty? food) empty]
        [else
         (local
           (
            (define (convert-to-string item)
              (cond
              [(number? item) (number->string item)]
              [(symbol? item) (symbol->string item)]
              [else item]))
            (define (make-button-row buttons)
              (cond
                [(empty? buttons) empty]
                [else 
                 (local
                   ((define label (convert-to-string (first buttons))))
                   (cons (make-button label callback3)
                            (make-button-row (rest buttons))))]))
            (define (items->buttons loi)
              (cond
                [(empty? loi) empty]
                [else (cons (make-button-row (first loi))
                            (items->buttons (rest loi)))])))
           (append (list (list (make-message title)))
                 (list (list a-message3))
                 (items->buttons pad)))])))
    (nonompad title pad)))

;; View:

(define a-message3 (make-message "N"))

(define (callback3 e)
  (draw-message a-message3 "Cant fix this without using lambda. I'm dumb. :("))

;; Controller:

(create-window (pad->gui "ERMAHGERD iPERD" pad))
;(create-window (pad->gui "ERMAHGERD iCARCULERTER" pad2))

;; Dont know how to make the callback function work without using lambda
;; Maybe when I'll know what the heck that magic lambda thingy does,
;; I can fix dis. For now Ill move on.