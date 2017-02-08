;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |15|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; -------------------------
;;        SECTION 15
;;    Manually Referential 
;;      Data Definitions
;; -------------------------
;;

(define-struct parent (children name date eyes))
;; A parent is a structure:
;; (make-parent loc n d e)
;; where loc is a list of children, n and e are symbols 
;; and d is a number.

;; A list of children is:
;; 1. empty or
;; 2. (cons p loc) where p is a parent
;;    and loc is a list of children

;; Definitions like these are said to be MUTUALLY RECURSIVE
;; or MUTUALLY REFERENTIAL.

;; Youngest generation:
(define Gustav (make-parent empty 'Gustav 1988 'brown))

(define Fred&Eva (list Gustav))

;; Middle Generation:
(define Adam (make-parent empty 'Adam 1950 'yellow))
(define Dave (make-parent empty 'Dave 1955 'black))
(define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
(define Fred (make-parent Fred&Eva 'Fred 1966 'pink))

(define Carl&Bettina (list Adam Dave Eva))

;; Oldest generation
(define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
(define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))

;; blue-eyed-children? : children -> boolean
;; to determine whether a child or any child in a list
;; has 'blue in the eyes field
(define (blue-eyed-children? loc)
  (cond
    [(empty? loc) false]
    [(blue-eyed-descendant? (first loc)) true]
    [else (blue-eyed-children? (rest loc))]))

;; blue-eyed-descendant? : parent -> boolean
;; to determine whether a-parent or any of its descendants
;; i.e. children and grandchildren have 'blue in the eyes field
(define (blue-eyed-descendant? parent)
  (cond
    [(empty? parent) false]
    [(symbol=? (parent-eyes parent) 'blue) true]
    [else (blue-eyed-children? (parent-children parent))]))

;; -------------------------
;; Exercise 15.1.1.
;; -------------------------

;; ********
;; (blue-eyed-descendant? Eva)  // ;; (make-parent Fred&Eva 'Eva 1965 'blue)

;; (blue-eyed-descendant? (make-parent Fred&Eva 'Eva 1965 'blue))
;; (cond
;;    [(empty? (make-parent Fred&Eva 'Eva 1965 'blue)) false]
;;    [(symbol=? (parent-eyes (make-parent Fred&Eva 'Eva 1965 'blue)) 'blue) true]
;;    [else (blue-eyed-children? (parent-children (make-parentFred&Eva 'Eva 1965 'blue)))]))
;; ==
;; (blue-eyed-descendant? (make-parent Fred&Eva 'Eva 1965 'blue))
;; (cond
;;    [FALSE]
;;    [(symbol=? (parent-eyes (make-parent Fred&Eva 'Eva 1965 'blue)) 'blue) true]
;;    [else (blue-eyed-children? (parent-children (make-parentFred&Eva 'Eva 1965 'blue)))]))
;; ==
;; (blue-eyed-descendant? (make-parent Fred&Eva 'Eva 1965 'blue))
;; (cond
;;    [(empty? (make-parent Fred&Eva 'Eva 1965 'blue)) false]
;;    [TRUE]
;;    [else (blue-eyed-children? (parent-children (make-parentFred&Eva 'Eva 1965 'blue)))]))
;; == TRUE 

;; ********
;; (blue-eyed-descendant? Bettina) // ;; (make-parent Carl&Bettina 'Bettina 1926 'green)

;; (blue-eyed-descendant? (make-parent Carl&Bettina 'Bettina 1926 'green))
;; (cond
;;    [(empty? (make-parent Carl&Bettina 'Bettina 1926 'green)) false]
;;    [(symbol=? (parent-eyes (make-parent Carl&Bettina 'Bettina 1926 'green)) 'blue) true]
;;    [else (blue-eyed-children? (parent-children (make-parent Carl&Bettina 'Bettina 1926 'green)))]))
;; ==
;; (blue-eyed-descendant? (make-parent Carl&Bettina 'Bettina 1926 'green))
;; (cond
;;    [FALSE]
;;    [(symbol=? (parent-eyes (make-parent Carl&Bettina 'Bettina 1926 'green)) 'blue) true]
;;    [else (blue-eyed-children? (parent-children (make-parent Carl&Bettina 'Bettina 1926 'green)))]))
;; ==
;; (blue-eyed-descendant? (make-parent Carl&Bettina 'Bettina 1926 'green))
;; (cond
;;    [(empty? (make-parent Carl&Bettina 'Bettina 1926 'green)) false]
;;    [FALSE]
;;    [else (blue-eyed-children? (parent-children (make-parent Carl&Bettina 'Bettina 1926 'green)))]))
;; ==
;; (define (blue-eyed-children? (list Adam Dave Eva))
;;  (cond
;;    [(empty? (list Adam Dave Eva)) false]
;;    [(blue-eyed-descendant? (first (list Adam Dave Eva))) true]
;;    [else (blue-eyed-children? (rest (list Adam Dave Eva)))]))
;; ==
;; (define (blue-eyed-children? (list Adam Dave Eva))
;;  (cond
;;    [FALSE]
;;    [(blue-eyed-descendant? (make-parent empty 'Adam 1950 'yellow)) true]
;;    [else (blue-eyed-children? (rest (list Adam Dave Eva)))]))
;; ==
;; (define (blue-eyed-children? (list Adam Dave Eva))
;;  (cond
;;    [(empty? (list Adam Dave Eva)) false]
;;    [FALSE]
;;    [else (blue-eyed-children? (list Dave Eva))]))
;; ==
;; (define (blue-eyed-children? (list Dave Eva))
;;  (cond
;;    [(empty? (list Adam Dave Eva)) false]
;;    [(blue-eyed-descendant? (make-parent empty 'Adam 1950 'yellow)) true]
;;    [else (blue-eyed-children? (list Dave Eva))]))
;; ==
;; reiterate til Eve, then answer is TRUE and that gets passed as a final answer
;; cba to evaluate. No point.

;; -------------------------
;; Exercise 15.1.2.
;; -------------------------

;; how-far-removed : tree -> number / boolean
;; to determine how far a blue eyed descendant is, if on exists
;; 0 - parent has blue eyes, add 1 for every level of descending
;; if no descendant has blue eyes, return false
;
;(define (how-far-removed tree)
;  (cond
;    [(symbol=? (parent-eyes tree) 'blue) 0]
;    [(blue-eyed-children? (parent-children tree)) 
;     (add1 (how-far-removed (parent-children tree)))]
;    [else false]))

;; mkei the fuck ....? I peeked at someone elses code, they had came up with this:

;; how-far-removed : parent -> number / boolean
(define (how-far-removed p)
  (cond
    [(blue-eyed-descendant? p)
     (cond
       [(symbol=? (parent-eyes p) 'blue) 0]
       [else (+ 1 (apply min (filter number? (how-far-removed-children (parent-children p)))))])]
    [else false]))

;; apply, min, filter...???
;; APPLY / MIN / FILTER THE FUCK?
;; mkei (apply min list) just picks out the minimum number out of a list
;; and (filter number? list) is some kind of boolean filter

;; how-far-removed-children : parent -> number / boolean
(define (how-far-removed-children children)
  (cond
    [(empty? children) empty]
    [else (cons
           (how-far-removed (first children))
           (how-far-removed-children (rest children)))]))

;(check-expect (how-far-removed Gustav) false)
;(check-expect (how-far-removed Eva) 0)
;(check-expect (how-far-removed Fred) false)
;(check-expect (how-far-removed Dave) false)
;(check-expect (how-far-removed Adam) false)
;(check-expect (how-far-removed Carl) 1)
;(check-expect (how-far-removed Bettina) 1)
;(define a (make-parent empty 'a 1988 'blue))
;(define a1 (make-parent empty 'a1 1989 'black))
;(define b (make-parent (list a a1) 'b 1977 'green))
;(define b1 (make-parent empty 'b1 1977 'blue))
;(define c (make-parent (list b b1) 'c 1967 'red))
;(define d (make-parent (list c) 'd 1967 'black))
;(check-expect (how-far-removed d) 2)

;; -------------------------
;; Exercise 15.1.3.
;; -------------------------

;; count-descendants : parent -> number
;; to produce a number of descendants, including parent
(define (count-descendants parent)
  (cond
    [(empty? parent) 0]
    [else (+ 1 (count-children (parent-children parent)))]))

;; count-children : child -> number
(define (count-children child)
  (cond
    [(empty? child) 0]
    [else (+ (count-descendants (first child)) (count-children (rest child)))]
    ))

;(check-expect (count-descendants Gustav) 1)
;(check-expect (count-descendants Eva) 2)
;(check-expect (count-descendants Carl) 5)


;; count-proper-descendants : parent -> number
;; to produce a number of descendants, excluding

(define (count-proper-descendants parent)
  (cond
    [(empty? parent) 0]
    [else (count-proper-children (parent-children parent))]))

;; count-proper-children : child -> number
(define (count-proper-children child)
  (cond
    [(empty? child) 0]
    [else (+ 1 (count-proper-children (parent-children (first child))) 
               (count-proper-children (rest child)))]
    ))

;(check-expect (count-proper-descendants Gustav) 0)
;(check-expect (count-proper-descendants Eva) 1)
;(check-expect (count-proper-descendants Carl) 4)


;; -------------------------
;; Exercise 15.1.4.
;; -------------------------

;; eye-colors : parent -> list
;; to produce a list of all eye colors in a tree
;; (eye color may occur more than once in a list

(define (eye-colors parent)
  (cons (parent-eyes parent)
        (children-eye-colors (parent-children parent))))

(define (children-eye-colors children)
  (cond
    [(empty? children) empty]
    [else
     (append
      (eye-colors (first children))
      (children-eye-colors (rest children)))]))

;(check-expect (eye-colors Gustav) (list 'brown))
;(check-expect (eye-colors Fred) (list 'pink 'brown))
;(check-expect (eye-colors Bettina) (list 'green 'yellow 'black 'blue 'brown))


;; -------------------------
;;  Extendex Exercise 15.3.
;;     More on Web Pages
;; -------------------------

(define-struct wp (header body))

;; A Web-page (Short: WP) is a structure:
;; (make-wp h p) where
;; h is a symbol and p is a web document

;; A Web-document is either:
;; 1. empty
;; 2. (cons s p) where
;;    s is a symbol and p is a document or
;; 3. (cons w p) where
;;    w is a web page and p is a document

;; -------------------------
;; Exercise 15.3.1.
;; -------------------------

;; size : web-page -> number
;; to produce a number of symbols (words) a web page contains
(define (size wp)
  (cond
    [(empty? wp) 0]
    [else (document-size (wp-body wp))]))

;; document-size : web-document -> number
;; to produce a n number of symbols (words) a web document contains
(define (document-size wdoc)
  (cond
    [(empty? wdoc) 0]
    [else (+
     (cond
       [(symbol? (first wdoc)) 1]
       [else (size (first wdoc))])
     (document-size (rest wdoc)))]))

(define wp0 (make-wp 'headertextrandom empty))
(define wp1 (make-wp 'headertext (cons 'symbol1 (cons 'symbol2 (cons 'symbol3 empty)))))
(define wp2 (make-wp 'headertext2 (cons 'symbol1 (cons 'symbol3
                      (cons (make-wp 'embedded (cons 'text1 (cons 'text2 empty))) empty)))))
(define wp3 (make-wp 'headertext2 (cons 'symbol1 (cons 'symbol3
                      (cons (make-wp 'embedded (cons 'text1 (cons 'text2 
                                                                  (cons 
                       (make-wp 'deep-wp-header (cons 'lilly (cons 'doc (cons 'holiday empty)))) empty)))) empty)))))

;(check-expect (size wp0) 0)
;(check-expect (size wp1) 3)
;(check-expect (size wp2) 4)

;; -------------------------
;; Exercise 15.3.2.
;; -------------------------

;; wp-to-file : web-page -> list of symbols
;; produces from a web page a list of symbols (los)
;; which contains all the words in a body and all the headers
;; of embedded web pages. Bodies of immediately embedded web pages are ignored.
(define (wp-to-file wp)
  (cond
    [(empty? wp) empty]
    [else (append (list (wp-header wp)) (wdoc-to-file (wp-body wp)))]))

;; wdoc-to-file : web-document -> list of words
;; to produce a list of words from all the symbols in the web document
(define (wdoc-to-file wdoc)
  (cond
    [(empty? wdoc) empty]
    [else (append (list 
                   (cond 
                  [(wp? (first wdoc)) (wp-header (first wdoc))]
                  [else (first wdoc)])
                   ) 
                  (wdoc-to-file (rest wdoc)))]))

;(check-expect (wp-to-file wp0) (list 'headertextrandom))
;(check-expect (wp-to-file wp1) (list 'headertext 'symbol1 'symbol2 'symbol3))
;(check-expect (wp-to-file wp2) (list 'headertext2 'symbol1 'symbol3 'embedded))


;; -------------------------
;; Exercise 15.3.3.
;; -------------------------

;; occurs : symbol wp -> boolean
;; to check whether a symbol occurs anywhere in
;; a web page, including imbedded ones.
(define (occurs wp s)
  (cond
    [(empty? wp) false]
    [(symbol? wp) (symbol=? wp s)]
    [(list? wp) (or
      (occurs  (first wp) s)
      (occurs-wdoc  (rest wp) s))]
    [else (or (symbol=? s (wp-header wp)) 
              (occurs-wdoc (wp-body wp) s))]))

;; occurs-wdoc : symbol wdoc -> boolean
;; to determine whether a symbol occurs anywhere
;; in a web document
(define (occurs-wdoc wdoc s)
  (cond
    [(empty? wdoc) false]
    [(symbol? (first wdoc))
     (or (symbol=? (first wdoc) s)
         (occurs-wdoc  (rest wdoc) s))]
    [(wp? (first wdoc)) (or
      (occurs  (first wdoc) s)
      (occurs-wdoc  (rest wdoc) s))]))

;(check-expect (occurs wp2 'text3) false)
;(check-expect (occurs wp2 'text2) true)


;; -------------------------
;; Exercise 15.3.4.
;; -------------------------

;; find : web-page symbol -> FALSE / list
;; to determine whether a web page contains the desired word AND
;; to produce false if symbol does not occur in the body of the page or in
;; imbedded web pages. if symbol occurs at least once, function produces a list of the
;; headers that are encountered on the way to the symbol.
(define (find wp s)
  (cond
    [(boolean? (finds (wp-body wp) s)) false]
    [else (append (list (wp-header wp)) (finds (wp-body wp) s))]))

;; finds : wp s -> boolean / list
;; same as before, just applying it on the body aka web document
(define (finds wdoc s)
  (cond
    [(empty? wdoc) false]
    [(symbol? (first wdoc)) 
      (cond
        [(symbol=? (first wdoc) s) empty]
        [else (finds (rest wdoc) s)])]
    [(and
      (wp? (first wdoc))
      (occurs (first wdoc) s)) 
      (find (first wdoc) s)]
    [else (finds (rest wdoc) s)]))

;(check-expect (find wp0 'booyah) false)
;(check-expect (find wp1 'symbol1) (list 'headertext))
;(check-expect (find wp2 'text1) (list 'headertext2 'embedded))
;(check-expect (find wp3 'doc) (list 'headertext2 'embedded 'deep-wp-header))


