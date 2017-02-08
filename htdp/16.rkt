;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |16|) (read-case-sensitive #t) (teachpacks ((lib "dir.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "dir.ss" "teachpack" "htdp")))))
;; -------------------------
;;         SECTION 16
;;     Development trough 
;;    Iterative Refinement
;; -------------------------
;;


;; Model 1: *****************
;; A file is a symbol

;; A directory (short: dir) is either:
;; 1. empty
;; 2. (cons f d) where f is a file and d is a dir, or
;; 3. (cons d1 d2) where both d1 and d2 are dirs


;; -------------------------
;;      Exercise 16.2.1.
;; -------------------------

(define Text (list 'part1 'part2 'part3))
(define Docs (list 'read! empty))
(define Code (list 'hang 'draw))
(define Libs (list Code Docs))
(define TS (list Text Libs 'read!))


;; -------------------------
;;      Exercise 16.2.2.
;; -------------------------

;; how-many : dir -> number
;; to consume a directory and produce the number
;; of files in the dir tree according to model 1
(define (how-many dir)
  (cond
    [(empty? dir) 0]
    [(symbol? dir) 1]
    [else (+ (how-many (first dir))
             (how-many (rest dir)))]))

;(check-expect (how-many TS) 7)


;; Model 2: *****************

(define-struct dir2 (name content))

;; A directory is a structure
;; (make-dir n c) where n is a symbol and 
;; c is a list of files and directories

;; A list-of-files-and-directories (short: LOFD) is either:
;; 1.empty
;; 2.(cons f d) where f is a file and d is a lofd, or:
;; 3.(cons d1 d2) where d1 is a dir and d2 is a lofd

;; So we have mutually recursive definitions and those
;; must be introduced together

;; -------------------------
;;      Exercise 16.2.3.
;; -------------------------

;; A directory is a structure
;; (make-dir n c s r) where n is a symbol
;; and c is a list of files and directories,
;; s is a number, which represents size of a directory
;; and c is a boolean whether dir is recognized by OS
;; lofd definition would remain the same.

;; -------------------------
;;      Exercise 16.2.4.
;; -------------------------

(define Code2 (make-dir2 'Code (list 'hang 'draw empty)))
(define Docs2 (make-dir2 'Docs (list 'read! empty)))
(define Libs2 (make-dir2 'Libs2 (list Code Libs)))
(define Text2 (make-dir2 'Text (list 'part1 'part2 'part3 empty)))
(define TS2 (make-dir2 'TS (list 'read! Text Libs)))

;; -------------------------
;;      Exercise 16.2.5.
;; -------------------------

;; how-many : dir -> number
;; to consume a dir and produce the number
;; of files in the dir tree according to model 2
(define (how-many2 dir)
  (cond
    [(empty? dir) 0]
    [(symbol? dir) 1]
    [(list? dir) (+
                  (how-many2 (first dir))
                  (how-many2 (rest dir)))]
    [else (+ (how-many2 (first (dir2-content dir)))
             (how-many2 (rest (dir2-content dir))))]))

;(check-expect (how-many2 TS2) 7)




;; Model 3: *****************

(define-struct file3 (name size content))

;; A file is a structure
;; (make-file n s x), where
;; n is a symbol, s is a number
;; and x is some Scheme value

;; Ignoring content field of a file for now.
;; Split field of dirs into a list of files
;; and a list of subdirectories.

;; A list-of-files (short: lof) is either:
;; 1. empty, or
;; 2. (cons s lof) where s is a file and lof is a list of files


(define-struct dir3 (name dirs files))

;; A dir is a structure:
;; (make-dir n ds fs), where
;; n is a symbol, ds is a list of directories
;; and fs is a list of files

;; A list-of-directories (lofd) is either:
;; 1.empty or
;; 2.(cons s lod) where s is a dir and lod is
;; a list of directories

;; -------------------------
;;      Exercise 16.3.1.
;; -------------------------

(define hang (make-file3 'hang 8 empty))
(define draw (make-file3 'draw 2 empty))
(define read2 (make-file3 'read! 19 empty))
(define Docs3 (make-dir3 'Docs empty (list read2)))
(define Code3 (make-dir3 'Code empty (list draw hang)))
(define Libs3 (make-dir3 'Libs (list Docs3 Code3) empty))
(define part1 (make-file3 'part1 99 empty))
(define part2 (make-file3 'part2 52 empty))
(define part3 (make-file3 'part3 17 empty))
(define read3 (make-file3 'read! 12 empty))
(define Text3 (make-dir3 'Text empty (list part1 part2 part3 read3)))
(define read1 (make-file3 'read! 10 empty))
(define TS3 (make-dir3 'TS (list Text3 Libs3) (list read1)))

;; // REQUIRES TEACHPACK DIR.SS //
(define MyDir (create-dir "X:\\Downloads\\For Unemployed People"))


;; -------------------------
;;      Exercise 16.3.2.
;; -------------------------

;; how-many : dir -> number
;; to consume a directory and determine how many
;; files dir tree contains according to model3
(define (how-many3 dir)
(+ (how-many-files3 (dir3-files dir))
   (how-many-dirs3 (dir3-dirs dir))))

;; how-many-files3 : lof -> number
(define (how-many-files3 lof)
  (cond
    [(empty? lof) 0]
    [(file3? lof) 1]
    [else (+ (how-many-files3 (first lof)) 
             (how-many-files3 (rest lof)))]))

;; how-many-dirs3 : lod -> recursion
(define (how-many-dirs3 lod)
  (cond
    [(empty? lod) 0]
    [(dir3? lod) (how-many3 lod)]
    [else (+ (how-many3 (first lod))
             (how-many-dirs3 (rest lod)))]))

;;(check-expect (how-many3 TS3) 7)
;; for this to work, replace above dir3 with dir and
;; file3? and dir3? with file? and dir? respectively
;;(check-expect (how-many3 MyDir) 18)

;; -------------------------
;;      Exercise 16.3.3.
;; -------------------------

;; du-dir : dir -> number
;; computes the total size of all
;; the files in entire directory tree
(define (du-dir dir)
  (+ (file-size3 (dir3-files dir)) (dir-size3 (dir3-dirs dir))
     (cond
       [(and (not (empty? (dir3-files dir))) (not (empty? (dir3-dirs dir)))) 1]
       [else 0])))

;; auxiliary f-ns:
;; file-size : lof -> number
(define (file-size3 lof)
  (cond
    [(empty? lof) 0]
    [else (+ (file3-size (first lof))
             (file-size3 (rest lof)))]))

;; dir-size3 : lod -> number
(define (dir-size3 lod)
  (cond
    [(empty? lod) 0]
    [else (+ (du-dir (first lod))
             (dir-size3 (rest lod)))]))

;(check-expect (du-dir TS3) 207) 


;; -------------------------
;;      Exercise 16.3.4.
;; -------------------------

;; find? : dir f -> boolean
;; to consume a dir-tree and a file name
;; and check whether the file with that name
;; occurs in the directory tree
(define (find? dir f)
  (or 
   (check-files (dir3-files dir) f)
   (check-dirs (dir3-dirs dir) f)))

;; check-files : lof f -> boolean
(define (check-files lof f)
  (cond
    [(empty? lof) false]
    [(symbol=? (file3-name (first lof)) f) true]
    [else (check-files (rest lof) f)]))

;; check-dirs : lod f -> boolean
(define (check-dirs lod f)
  (cond
    [(empty? lod) false]
    [(find? (first lod) f) true]
    [else (check-dirs (rest lod) f)]))

;(check-expect (find? TS3 'lag) false)
;(check-expect (find? TS3 'hang) true)

;; -------------------------
;;     Challenge 16.3.4.
;; -------------------------

;; find : dir f -> path to file (list of dirs) / boolean false
;; to produce a list of directories as a path to file if the file
;; is in the directory tree, otherwise output false

;; find : dir f -> lod / false
(define (find dir f)
  (cond
    [(find? dir f) (create-path dir f)]
    [else false]))

;; create-path : dir f -> lod
(define (create-path dir f)
  (cond
    [(empty? dir) empty]
    [(list? dir) (append(create-path (first dir) f) (create-path (rest dir) f))]
    [(empty? (dir3-dirs dir)) (list (dir3-name dir))]
    [(and
      (not (check-files (dir3-files dir) f))
      (find? (first (dir3-dirs dir)) f)
      (check-dirs (rest (dir3-dirs dir)) f))
     (list 
           (append (list (dir3-name dir)) (create-path (first (dir3-dirs dir)) f))
           (append (list (dir3-name dir)) (create-path (rest (dir3-dirs dir)) f)))]
    [(and
       (check-files (dir3-files dir) f)
      (find? (first (dir3-dirs dir)) f)
      (check-dirs (rest (dir3-dirs dir)) f))
     (list (list (dir3-name dir))
           (append (list (dir3-name dir)) (create-path (first (dir3-dirs dir)) f))
           (append (list (dir3-name dir)) (create-path (rest (dir3-dirs dir)) f)))]
    [(and
      (check-files (dir3-files dir) f)
      (check-dirs (dir3-dirs dir) f))
     (list (list (dir3-name dir)) 
           (append (list (dir3-name dir)) (check-dirs3 (dir3-dirs dir) f)))]

    [else (append (list (dir3-name dir)) (check-dirs3 (dir3-dirs dir) f))]))


;; check-dirs : lod f -> empty / dirname
(define (check-dirs3 lod f)
  (cond
    [(empty? lod) empty]  
    [(check-files (dir3-files (first lod)) f) (create-path (first lod) f)]
    [else (check-dirs3 (rest lod) f)]))


;(check-expect (find TS3 'read) false)
;(check-expect (find TS3 'read!) (list (list 'TS) (list 'TS 'Text) (list 'TS 'Libs 'Docs)))


;; Note: the solution is quite a mess, still doesnt work quite right if given more than 3 occurences,
;; it will display nested paths inside in a list together with parent, i.e. try putting
;; the same file in 2 adjacent folders and you will see. Maybe it needs more conditionals... -__-
;; So its not complete, but I've already spent more than 2 hours on this mess, 
;; so I'm done with this for now. Moving on...