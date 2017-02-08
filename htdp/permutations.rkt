;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname permutations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;; permutations : list -> list-of-lists
;;; to consume a list of items
;;; and output all possible arrangements
;;; of those items
;(define (permutations loi)
;  (cond
;    [(empty? loi) (cons empty empty)]
;    [else (combine-all/with-all (first loi)
;                                  (permutations (rest loi)))]))
;
;;; insert-item/everywhere : item  list-of-items -> list-of-lists-of-items
;;; to consume an item and a list of items and permutate dem
;(define (combine-all/with-all item allitems)
;  (cond
;    [(empty? allitems) empty]
;    [else (append 
;           (combine-item/with-item item (first allitems))
;           (combine-all/with-all item (rest allitems)))]))
;
;;; combine-item/with-item : item item/list-of-items -> list-of-lists-of-items
;;; to combine an item with an item or list 
;(define (combine-item/with-item  item1 item/list)
;  (cond
;    [(empty? item/list) (list (cons item1 empty))]
;    [else (cons
;           (append
;            (list item1 (first item/list))
;            (rest item/list))
;           (combine-first/with-all
;            (first item/list)
;            (combine-item/with-item item1 (rest item/list)))
;           )]))
;
;;; combine-first/with-all : item list-of-items -> list-of-items
;;; to attach the missing part we leave behind as we progress as we
;;; combine an item with rest of the items in the list
;(define (combine-first/with-all item item/list)
;  (cond
;    [(empty? item/list) empty]
;    [else (cons (cons item (first item/list))
;                (combine-first/with-all item (rest item/list)))
;          ]))
;
;;(define testlist (list 'R 'U 'M))
;;(permutations testlist)