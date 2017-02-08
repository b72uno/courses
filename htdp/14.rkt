;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |14|) (read-case-sensitive #t) (teachpacks ((lib "guess.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp")))))
;; -------------------------
;; CHAPTER 14
;; -------------------------


(define-struct child (father mother name date eyes))

;; example:
;; (make-child Carl Betting 'Adam 1950 'yellow)

;; A child node is (make-child f m na de ec) where
;; 1. f and m are either:
;;    a. empty or
;;    b. child nodes
;; 2. na and ec are symbols
;; 3. da is a number

;; We can redefine the collection of nodes in a family tree instead:

;; A family-tree-node is either:
;; 1. empty or
;; 2. (make-child f m na da ec)
;; where f and m are ftns
;; na and ec are symbols and da is a number

;; Oldest generation:
(define Carl (make-child empty empty 'Carl 1926 'purple))
(define Bettina (make-child empty empty 'Bettina 1926 'white))

;; Middle generation:
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Youngest generation:
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))


;; Example function which consumes family tree nodes

;; fun-for-ftn : ftn -> ???
;(define (fun-for-ftn a-ftree) ...
;  (cond
 ;   [(empty? a-tree) ...]
  ;  [else ; (child? a-ftree) ...
;(fun-for-ftn (child-father a-ftree)) ...
;(fun-for-ftn (child-mother a-ftree))...
;(child-name a-ftree) ...
;(child-date a-ftree) ...
;(child-eyes a-ftree) ...
;]))


;; Concrete example:
;; blue-eyed-ancestor? : ftn -> boolean
;; to determine whether a-ftree contains a child
;; structure with 'blue in the eyes field
(define (blue-eyed-ancestor? a-ftree)
  (cond
    [(empty? a-ftree) false]
    [else (or
           (symbol=? (child-eyes a-ftree) 'blue)
           (blue-eyed-ancestor? (child-father a-ftree))
           (blue-eyed-ancestor? (child-mother a-ftree)))]))

;; Contract & purpose
;; blue-eyed-ancestor : ftn -> boolean
;; to determine whether a-ftree contains a child
;; structure with 'blue in the eyes field

;; example
;; (blue-eyed-ancestor? Carl) -> false
;; (blue-eyed-ancestor? Gustav)-> true

;(check-expect (blue-eyed-ancestor? Carl) false)
;(check-expect (blue-eyed-ancestor? Gustav) true)


;; -------------------------
;; Exercise 14.1.3.
;; -------------------------

;; count-persons : a-ftree -> number
;; to count persons in a family tree
(define (count-persons a-ftree)
  (cond
    [(empty? a-ftree) 0]
    [else (+ 1 (+ (count-persons (child-mother a-ftree))
                       (count-persons (child-father a-ftree))))]))

;(check-expect (count-persons Carl) 1)
;(check-expect (count-persons Gustav) 5)

;; -------------------------
;; Exercise 14.1.4.
;; -------------------------

;; total-age : a-ftree current-year -> number
;; to produce the sum all ages in a family tree
(define (total-age a-ftree current-year)
  (cond
    [(empty? a-ftree) 0]
    [else (+ (- current-year (child-date a-ftree))
             (total-age (child-father a-ftree) current-year)
             (total-age (child-mother a-ftree) current-year))]))
         
;; average-age : a-ftree current-year -> number
;; to produce the average age of all people in family tree
(define (average-age a-ftree current-year)
 (/ (total-age a-ftree current-year) (count-persons a-ftree)))

;(check-expect (average-age Gustav 2000) 45.8)
;(check-expect (average-age Bettina 2000) 74)

;; -------------------------
;; Exercise 14.1.5.
;; -------------------------

;; eye-colors : a-ftree -> list
;; to produce a list of all eye colors in a tree
;; (an eye color may occur more than once)
(define (eye-colors a-ftree)
  (cond
    [(empty? a-ftree) empty]
    [else (append (list (child-eyes a-ftree))
            (eye-colors (child-mother a-ftree))
               (eye-colors (child-father a-ftree)))]))


;; -------------------------
;; Exercise 14.1.6.
;; -------------------------

;; proper-blue-eyed-ancestor? : a-ftree -> boolean
;; to determine whether one has a proper blue eyed ancestor
;; (a child node must have an ancestor with blue eyes disregarding
;; the childs own eye color)
(define (proper-blue-eyed-ancestor? a-ftree) 
  (cond
    [(empty? a-ftree) false]
    [else (or (blue-eyed-ancestor? (child-father a-ftree))
              (blue-eyed-ancestor? (child-mother a-ftree)))]))

;(check-expect (blue-eyed-ancestor? Eva) true)
;(check-expect (proper-blue-eyed-ancestor? Eva) false)
;(check-expect (proper-blue-eyed-ancestor? Gustav) true)


;; -------------------------
;; Extended Exercise 14.2.
;;   BINARY SEARCH TREES
;; -------------------------
;; 
;; similiar to family trees, but instead contains nodes
(define-struct node (ssn name left right))
;; A binary tree (Short: BT) is either:
;; 1. false, or
;; 2. (make-node soc pn lft rgt)
;; where soc is a number pn is a symbol, lft and rgt are BTs
;; example: (make-node 15 'd false (make-node 24 'i false false))

;; defining some BTs to work on in future exercises
(define TreeA (make-node 63 'topn 
                  (make-node 29 'ln1 (make-node 15 'ln2 (make-node 10 'ln2ln1 false false)
                                                        (make-node 24 'ln2rn1 false false))
                   false)
                  (make-node 89 'rn1 (make-node 77 'rn1ln1 false false)
                                     (make-node 95 'rn2 false (make-node 99 'rn3 false false)))
                  ))
(define TreeB (make-node 63 'topn 
                  (make-node 29 'ln1 (make-node 15 'ln2 (make-node 87 'ln2ln1 false false)
                                                        (make-node 24 'ln2rn1 false false))
                   false)
                  (make-node 89 'rn1 (make-node 33 'rn1ln1 false false)
                                     (make-node 95 'rn2 false (make-node 99 'rn3 false false)))
                  ))


;; -------------------------
;; Exercise 14.2.1.
;; -------------------------

;; contains-bt : BT number -> boolean
;; to determine whether a number occurs in a tree
(define (contains-bt BT number)
  (cond
    [(false? BT) false]
    [else (or
           (= (node-ssn BT) number)
           (contains-bt (node-left BT) number)
           (contains-bt (node-right BT) number))]))

;(check-expect (contains-bt TreeA 33) false)
;(check-expect (contains-bt TreeA 77) true)


;; -------------------------
;; Exercise 14.2.2.
;; -------------------------

;; search-bt : BT number -> symbol / boolean
;; if the tree contains a node structure whose number is n
;; then function produces the value of the pn (name) in that node
;; otherwise outputs false
(define (search-bt BT n)
  (cond
    [(false? BT) false]
    [(= (node-ssn BT) n) (node-name BT)]
    [(contains-bt (node-left BT) n) (search-bt (node-left BT) n)]
    [else (search-bt (node-right BT) n)]))

;(check-expect (search-bt TreeA 99) 'rn3)
;(check-expect (search-bt TreeB 77) false)
;(check-expect (search-bt TreeA 77) 'rn1ln1)


;; Binary tree that has an ORDERED sequence of information is a BINARY SEARCH TREE
;; every binary search tree is a binary tree, but not every binary tree is a binary search tree!

;; A binary-search-tree (Short: BST) is a BT:
;; 1. false is always a BST;
;; 2. (make-nod soc pn lft rgt) is a BST if:
;;    a. lft and rgt are BSTs,
;;    b. all ssn numbers in lft are smaller than soc, and
;;    c. all ssn numbers in rgt are largen than soc.


;; -------------------------
;; Exercise 14.2.3.
;; -------------------------

;; Data analysis & Design
;; (define (inorder BT)...)
;; inorder is a function which consumes a binary tree BT
;; and produces a list which contains numbers
;; in left-to-right order from the binary tree

;; Purpose & Contract
;; inorder : BT -> list
;; to produce a list of all the ssn numbers in the tree
;; the list contains the numbers in left-to-right order

;; Examples:
;; (inorder TreeA) -> (list 10 15 24 29 63 77 89 95 99)
;; (inorder TreeB) -> (list 87 15 24 29 63 33 89 95 99)

;; Template:
;;(define (inorder BT)
;;  (cond
;;    [(empty? BT) ...]
;;    [else ... 
;;     (node-ssn BT) ...
;;     (node-name BT) ...
;;     (node-left BT) ...
;;     (node-right BT) ...
;;     ...]))

;; Definition
(define (inorder BT)
  (cond
    [(false? BT) empty]
    [else
     (append
       (inorder (node-left BT))
       (list (node-ssn BT))
       (inorder (node-right BT)))]))
;; Tests:
;; (check-expect (inorder TreeA)(list 10 15 24 29 63 77 89 95 99))
;; (check-expect (inorder TreeB)(list 87 15 24 29 63 33 89 95 99))

;; -------------------------
;; Exercise 14.2.4.
;; -------------------------

;; search-bst : BST number -> symbol / false
;; to check whether a BST contains a node with given number
;; if true, outputs the name, if false it produces false
;; YOU DO NOT FEED THIS FUNCTION A NON-BST!
(define (search-bst BST n)
  (cond
    [(false? BST) false]
    [(= (node-ssn BST) n) (node-name BST)]
    [(> (node-ssn BST) n) (search-bst (node-left BST) n)]
    [else (search-bst (node-right BST) n)]))
;; YOU DO NOT FEED THIS FUNCTION A NON-BST!
;; YOU DO NOT FEED THIS FUNCTION A NON-BST!
;; For a non-bst USE (search-bt BT n) INSTEAD!

;; -------------------------
;; Exercise 14.2.5.
;; -------------------------

;; create-bst : BST number symbol -> BST
;; checking someones elses source code on this one
;; dont quite get it by myself

(define (create-bst BST ssn name)
  (cond
    [(false? BST) (make-node ssn name false false)]
    [(< ssn (node-ssn BST)) (make-node
                             (node-ssn BST)
                             (node-name BST)
                             (create-bst (node-left BST) ssn name)
                             (node-right BST))]
    [(> ssn (node-ssn BST)) (make-node
                             (node-ssn BST)
                             (node-name BST)
                             (node-left BST)
                             (create-bst (node-right BST) ssn name))]
    [else (error "Invalid Serial Number")]))

;
;(check-expect
;(create-bst 
; (create-bst
;  (create-bst
;   (create-bst
;    (create-bst
;     (create-bst
;      (create-bst
;       (create-bst
;        (create-bst false 63 'topn)
;        29 'ln1)
;       15 'ln2)
;      10 'ln2ln1)
;     24 'ln2rn1)
;    89 'rn1)
;   77 'rn1ln1)
;  95 'rn2)
; 99 'rn3) TreeA)


;; -------------------------
;; Exercise 14.2.6.
;; -------------------------

;; create-bst-from-list : list -> BST
;; consumes a list of numbers and names and produces
;; a BST by repeatedly applying create-bst
;; (create-bst : BST number symbol -> BST)

;; A list-of-number/name is either:
;; 1. empty, or
;; 2. (cons (list ssn nom) lonn
;; where ssn is a number, nom is a symbol,
;; and lonn is a list of number/name

(define (create-bst-from-list lonn)
  (cond
    [(empty? lonn) false]
    [else (create-bst (create-bst-from-list (rest lonn)) (first (first lonn)) 
                                                          (second (first lonn)))]))

(define sample
  '((99 rn3)
    (77 rn1ln1)
    (24 ln2rn1)
    (10 ln2ln1)
    (95 rn2)
    (15 ln2)
    (89 rn1)
    (29 ln1)
    (63 topn)))

;(check-expect (create-bst-from-list sample) TreeA)


;; -------------------------
;;         Part 14.3.
;;       LISTS IN LISTS
;; -------------------------

;; A Web-page (short: WP) is either:
;; 1.empty;
;; 2. (cons s wp)
;;     where s is a symbol and wp is a web page, or
;; 3. (cons ewp wp)
;;     where both wep and wp are Web pages

;; Immediately embedded web pages. 
;; (ie the one at the beginning of a constructed list)

;; Examples:

;; plain page:
(define plainPage '(The Teachscheme! Project aims to improve the problem-solving and organization
skills of high school students. It provides software and lecture notes as well
exercises and solutions for teachers.))

;; complex page:
(define complexPage
'(The TeachScheme Web Page
 Here you can find:
(LectureNotes for Teachers)
(Guidance for (DrScheme: a Scheme programming environment))
(Exercise Sets)
(Solutions for Exercises)
For further Scheme information: write to scheme@cs))

;; (DrScheme: ... ) is the embedded one here with respec to the entire page

;; size : WP -> number
;; to count the number of symbols that occur in a-wp
;; now, according to our wp definition we need 3 cond clauses:
;; 1st for empty, 2nd for a symbol and 3rd for embedded page.
(define (size a-wp)
  (cond
    [(empty? a-wp) 0]
    [(symbol? (first a-wp)) (+ 1 (size (rest a-wp)))]
    [else (+ (size (first a-wp)) (size (rest a-wp)))]))

;(size plainPage)
;(size complexPage)

;; -------------------------
;; Exercise 14.3.2.
;; -------------------------

;; occurs1 : wp symbol -> number
;; to determine how many times a symbol appears in a web page
;; (IGNORES NESTED WEB PAGES)
(define (occurs1 wp symbol)
  (cond
    [(empty? wp) 0]
    [(symbol? (first wp))
     (cond
       [(symbol=? (first wp) symbol) (+ 1 (occurs1 (rest wp) symbol))]
       [else (occurs1 (rest wp) symbol)])]
    [else (occurs1 (rest wp) symbol)]))

;(check-expect (occurs1 complexPage 'Scheme) 1)

;; occurs2 : wp symbol -> number
;; to determine how many times a symbol appears in a web page
;; (INCLUDES NESTED WEB PAGES)
(define (occurs2 wp symbol)
  (cond
    [(empty? wp) 0]
    [(symbol? (first wp))
     (cond
       [(symbol=? (first wp) symbol) (+ 1 (occurs2 (rest wp) symbol))]
       [else(occurs2 (rest wp) symbol)])]
    [else (+ (occurs2 (first wp) symbol) (occurs2 (rest wp) symbol))]))

;(check-expect (occurs2 complexPage 'Scheme) 2)

;; -------------------------
;; Exercise 14.3.3.
;; -------------------------

;; replace : symbol1 symbol2 a-wp -> a-wp
;; to replace all occurrences of a symbol1 with symbol2 in a web page

;; mkei this one's hard, need examples
;; (replace empty symbol1 symbol2) -> empty
;; (replace '(symbol3 symbol1 symbol4 symbol5) symbol1 symbol2) -> ...
;; (replace '(symbol3 (symbol4 symbol1) symbol5 symbol6) symbol1 symbol2) -> ...

(define (replace wp symbol1 symbol2)
  (cond
    [(empty? wp) empty]
    [(symbol? (first wp))
     (cond
       [(symbol=? (first wp) symbol1) 
        (append (list symbol2) (replace (rest wp) symbol1 symbol2))]
       [else 
        (append (list (first wp)) (replace (rest wp) symbol1 symbol2))])]
    [else (append (list (replace (first wp) symbol1 symbol2))
                        (replace (rest wp) symbol1 symbol2))]))

;(replace complexPage 'DrScheme: 'DrRacket:)

;; -------------------------
;; Exercise 14.3.4.
;; -------------------------
;; Didnt figure this one out on my own,
;; would have never thought of using max function here!

;; depth : wp -> number
;; to compute the depth of a web page
;; ex: all symbols -> depth: 0
;; 1 embedded page -> depth: 1
;; Embedded page within embedded -> depth: 1 + depth of embedded page

(define (depth wp)
  (cond
    [(empty? wp) 0]
    [(symbol? (first wp)) (depth (rest wp))]
    [else
     (max ( + 1 (depth (first wp))) (depth (rest wp)))]
    ))
                
;(check-expect (depth '(dadad (bzbzb) bzbzasd (wqeq (eqweqe (eqewqe))))) 3)
;(check-expect (depth complexPage) 2)
;(check-expect (depth '(dam dam)) 0)


;; -------------------------
;;  Extended Exercise 14.4.
;;    Evaluating Scheme
;; -------------------------

;; DrScheme consists of 2 parts
;; 1st checks whether the definitions and expressions
;; are gramatically corret, the 2nd one evaluates 
;; Scheme expressions


(define-struct add (left right))
(define-struct mul (left right))


;; -------------------------
;; Exercise 14.4.1.
;; -------------------------

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

;; -------------------------
;; Exercise 14.4.2.
;; -------------------------

;; numeric? : expression -> boolean
;; to check whether the expression is numeric (all values are numbers only)
(define (numeric? expr)
  (cond
    [(symbol? expr) false]
    [(string? expr) false]
    [(number? expr) true]
    [(mul? expr) (and (numeric? (mul-left expr))
                      (numeric? (mul-right expr)))]
    [(add? expr) (and (numeric? (add-left expr))
                      (numeric? (add-right expr)))]
    [else (error "Invalid Scheme expression")]))
     
;(check-expect (numeric? (make-add (make-mul 20 3) 33)) true)
;(check-expect (numeric? (make-mul 3.14 (make-mul 'r 'r))) false)

;; -------------------------
;; Exercise 14.4.3.
;; -------------------------

;; A numeric expression is:
;; 1. A number
;; 2. A structure (make-mul x y) or (make-add x y) where
;;    x and y are numbers or numeric expressions.


;; evaluate-expression : expr -> number / error
;; to evaluate a scheme expression, if there are variables, throw error
(define (evaluate-expression expr)
  (cond
    [(number? expr) expr]
    [(numeric? expr)
     (cond
       [(mul? expr)
        (* (evaluate-expression (mul-left expr)) 
           (evaluate-expression (mul-right expr)))]
       [(add? expr)
        (+ (evaluate-expression (add-left expr)) 
           (evaluate-expression (add-right expr)))]
       )]
    [else (error "Invalid Scheme expression")]))


;(check-expect (evaluate-expression (make-add (make-mul 20 3) 33)) 93)


;; -------------------------
;; Exercise 14.4.4.
;; -------------------------

;; subst : var num expr -> expr
;; to substitute all occurences of a variable with a numeric value
;; in expression and produce a new expression
(define (subst var num expr)
  (cond
    [(equal? var expr) num]
    [(add? expr) (make-add (subst var num (add-left expr)) 
                           (subst var num (add-right expr)))]
    [(mul? expr) (make-mul (subst var num (mul-left expr))
                           (subst var num (mul-right expr)))]
    [(symbol? expr) expr]
    [(numeric? expr) expr]
    [else (error "Invalid Scheme Expression")]))


;(check-expect (subst 'z 5 5) 5)
;(check-expect (subst 'g 2 'g) 2)
;(check-expect (subst 'l 2 'p) 'p)
;(check-expect (subst 'r 6 (make-mul 3.14 (make-mul 'r 'r))) 
;              (make-mul 3.14 (make-mul 6 6)))
;(check-expect (subst 'o 3 (make-add (make-mul 3.14 (make-mul 'o 'o)) (make-mul 3.14 (make-mul 'i 'i))))
;              (make-add (make-mul 3.14 (make-mul 3 3)) (make-mul 3.14 (make-mul 'i 'i))))
