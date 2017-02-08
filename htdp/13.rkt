;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |13|) (read-case-sensitive #t) (teachpacks ((lib "guess.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.ss" "teachpack" "htdp") (lib "draw.ss" "teachpack" "htdp") (lib "arrow.ss" "teachpack" "htdp")))))
;; -------------------------
;; Section 13
;; -------------------------

;; Using cons is cumbersome
;; use list instead
;; <prm> = list
;; <val> = (list <val> ... <val>)
;; (list exp1 ... expn)
;; stands for
;; (cons exp1 (cons ... (cons expn empty)))


;; You can also apply lists to expressions (+ 1 2)
;; but before the list is constructed, it must be evaluated
;; if an error occurs, theo list is never formed
;; list behaves just like any other primitive operation

;; -------------------------
;; Exercise 13.0.3.
;; -------------------------

;;(check-expect (list 0 1 2 3 4 5)
;;(cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 empty)))))))
;;
;;(check-expect (list (list 'adam 0) (list 'eve 1) (list 'louisXIV 2))
;; (cons (cons 'adam (cons 0 empty)) 
;;       (cons (cons 'eve (cons 1 empty))
;;            (cons (cons 'louisXIV (cons 2 empty)) empty))))
;;
;;(check-expect (list 1 (list 1 2) (list 1 2 3))
;;              (cons 1 (cons (cons 1 (cons 2 empty)) 
;;                            (cons (cons 1 (cons 2 (cons 3 empty))) 
;;                                  empty))))
              
;; -------------------------
;; Exercise 13.0.4.
;; -------------------------

;;(check-expect (cons 'a (cons 'b (cons 'c (cons 'd (cons 'e empty)))))
;;              (list 'a 'b 'c 'd 'e))
;;
;;(check-expect (cons (cons 1 (cons 2 empty)) empty)
;;              (list (list 1 2)))
;;
;;(check-expect (cons 'a (cons (cons 1 empty) (cons false empty)))
;;              (list 'a (list (list 1) false)))
;;
;;(check-expect (cons (cons 1 (cons 2 empty)) (cons (cons 2 (cons 3 empty)) empty))
;;              (list (list 1 2) (list 2 3)))

;; -------------------------
;; Exercise 13.0.5.
;; -------------------------

;;(check-expect (cons 'a (list 0 false)) (cons 'a (cons 0 (cons false empty))))
;;(check-expect (list (cons 1 (cons 13 empty))) (cons (cons 1 (cons 13 empty)) empty))
;;(check-expect (list empty empty (cons 1 empty)) 
;;              (cons empty (cons empty (cons (cons 1 empty) empty))))
;;(check-expect (cons 'a (cons (list 1) (list false empty)))
;;              (cons 'a (cons (cons 1 empty) (cons false (cons empty empty)))))


;; -------------------------
;; Exercise 13.0.6.
;; -------------------------

;;(check-expect (list (symbol=? 'a 'b) (symbol=? 'c 'c) false) 
;;              (cons false (cons true (cons false empty))))
;;(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
;;              (cons 30 (cons 200 (cons 0.5 empty))))
;;(check-expect (list 'dana 'jane 'mary 'laura) 
;;              (cons 'dana (cons 'jane (cons 'mary (cons 'laura empty)))))


;; -------------------------
;; Exercise 13.0.7.
;; -------------------------

;;(check-expect (first (list 1 2 3)) 1)
;;(check-expect (rest (list 1 2 3)) (cons 2 (cons 3 empty)))

;; -------------------------
;; Exercise 13.0.8.
;; -------------------------

;;(check-expect '(1 a 2 b 3 c)
;;              (list 1 'a 2 'b 3 'c))
;;
;;(check-expect '((alan 1000)
;;                (barb 2000)
;;                (carl 1500)
;;                (dawn 2300))
;;              (list (list 'alan 1000) 
;;                    (list 'barb 2000) 
;;                    (list 'carl 1500) 
;;                    (list 'dawn 2300)))
;;
;;(check-expect '((My First Paper)
;;                (Sean Fisler)
;;                (Section 1
;;                         (Subsection 1 Life is difficult)
;;                         (Subsection 2 But Learning Things makes it interesting))
;;                (Section 2
;;                         Conclusion What conclusion?))
;;              (list
;;               (list 'My 'First 'Paper)
;;               (list 'Sean 'Fisler)
;;               (list 'Section 1 (list 'Subsection 1 'Life 'is 'difficult)
;;                                (list 'Subsection 2 'But 'Learning 'Things 'makes 'it 'interesting))
;;               (list 'Section 2 'Conclusion 'What 'conclusion?)))
