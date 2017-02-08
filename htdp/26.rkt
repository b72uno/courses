;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |26|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
 ;;  ---------------------------
;;          Section 25
;; ----------------------------


;; Section 26
;; Designing Algorithms 
;; ----------------------

;; Remember 6 general stages of structural design recipe:

;; 1. Data analysis and design
;; 2. Contract, purpose, header
;; 3. Function examples
;; 4. Template

;; General template for algorithms
;(define (generative-recursive-fun problem)
;  (cond
;    [(trivially-solvable? problem)
;     (determine-solution problem)]
;    [else
;     (combine-solutions
;       ... problem ...
;       (generative-recursive-fun (generate-problem-1 problem))
;       
;       (generative-recursive-fun (generate-problem-n problem)))]))


;; 5. Definition

;; Think and answer:
;; a. What is trivially solvable problem?
;; b. What is a corresponding solution?
;; c. How do we generate new, easily solvable problems from
;;    the original? Is there one or more new ones we can generate?
;; d. Is the solution of the given problem the same as the solution
;;   (one of) the new problems? Combine solutions?


;; 6. Tests


;; -------------------------
;;    Exercise 26.0.7.
;; -------------------------
;; Formulate informal answers to the four key questions
;; for the problem of modeling balls movement [25.xx]

;; a. Ball is out of bounds?
;; b. Do nothing.
;; c. Generate the structure, ball, over again, check if out of bounds.
;; d. Dont know. I guess solution is the same, once conditions are met.



;; -------------------------
;;    Exercise 26.0.8.
;; -------------------------
;; Same thing for quick-sort problem. How many
;; instances of generate-problem are there?

;; a. List is empty
;; b. Return empty, dont give a fuck.
;; c. Sort the list. Generate 3 new problems. > < and =, I guess.
;; d. No solutions are not the same. I think. No idea tbh.



;; Section 26.1
;; Termination
;; ----------------------

;; The internal recursions dont consume
;; an immediate component of the input, 
;; some new piece of data is generated from
;; the input. Therefore infinite loops. fml.


;; Design process for algorithms requires one more
;; step in design recipe: a TERMINATION ARGUMENT,
;; which explains why the process produces
;; an output for every input and how the f implements
;; this idea or a warning when f wont terminate.

;; Example for quick-sort function:
;; At each step, quick-sort partitions the list into two 
;; sublists using smaller-items and larger-items. Each function 
;; produces a list that is smaller than the input (the second 
;; argument), even if the threshold (the first argument) is an
;; item on the list. Hence each recursive application of quick-sort
;; consumes a strictly shorter list than the given one. Eventually,
;; quick-sort receives and returns empty.


;; -------------------------
;;    Exercise 26.1.1.
;; -------------------------
;; screw this, im done rewriting the book.
;; tabulate-div : number -> (listof number)
;; to consume a number n and tabulate the list
;; of all its divisors starting with 1 and ending in n.
(define (tabulate-div n) 
  (filter (lambda (x) (not (> (remainder n x) 0))) (build-list n add1)))

;(check-expect (tabulate-div 5) '(1 5))
;(check-expect (tabulate-div 20) '(1 2 4 5 10 20))

;; -------------------------
;;    Exercise 26.1.2.
;; -------------------------
;; merge-sort : (listof numbers) -> (listof numbers)
;; Merge sort - sorts a list of # in asc order
(define (merge-sort lon)
  (local (
          (define slon (make-singles lon))
          (define (until f lon)
            (if (= (length lon) 1)
                lon
             (until  f (f lon)))))
    (first (until merge-all-neighbors slon))))
;; Uses 2 auxiliary functions:
;; make-singles : (listof num) -> (listof (listof num))
;; generates list of one-item lists of list of numbers
(define (make-singles alon) (map list alon))
;(check-expect (make-singles (list 2 5 9 3))
;        (list (list 2) (list 5) (list 9) (list 3)))
;; merge-all-neighbors : (list (listof X) (listof Y) (listof A) (listof B)...)
;; -> (listof (listof X Y) (listof A B))
;; merges pairs of neighboring lists.
(define (merge-all-neighbors lolon)
  (if (or (empty? lolon) (empty? (rest lolon)))
      lolon
      (cons (merge (first lolon) (second lolon))
            (merge-all-neighbors (rest (rest lolon))))))

;; merge : (listof numbers) (listof numbers) -> (listof numbers)
;; to merge two sorted lists of numbers into one sorted list of numbers
(define (merge lon1 lon2)
  (if (or (empty? lon1) (empty? lon2))
      (if (empty? lon1) lon2 lon1)
      (if (< (first lon1) (first lon2))
          (cons (first lon1) (merge (rest lon1) lon2))
          (cons (first lon2) (merge lon1 (rest lon2))))))

;; Do not feed it unsorted lists, havent tested, shit might go wrong.
;(check-expect (merge-all-neighbors (list (list 2) (list 5) (list 9) (list 3)))
;        (list (list 2 5) (list 3 9)))
;
;(check-expect(merge-all-neighbors (list (list 2 5 5 9) (list 3 6 8 9)))
;        (list (list 2 3 5 5 6 8 9 9)))

;; Merge sort uses make-singles to create a list of single lists.
;; then relies on merge-all-neighbors to shorten the list of lists
;; until it contains a single list. The latter is the result.

;(check-expect (merge-sort (list 8 2 3 4 5 7 1 1 2 9 3 4 10 9 6))
;              (list 1 1 2 2 3 3 4 4 5 6 7 8 9 9 10))




;; Section 26.2
;; Structural vs Generative Recursion
;; -----------------------------------

;(define (generative-recursive-fun problem)
;  (cond
;    [(trivially-solvable? problem)
;     (determine-solution problem)]
;    [else
;      (combine-solutions
;	problem
;	(generative-recursive-fun (generate-problem problem)))]))


;; -------------------------
;;    Exercise 26.2.1.
;; -------------------------
;; Define "determine-solution" and "combine-solutions" so that
;; the function "generative-recursive-fun" computes the length
;; of its input.

;; No idea. Use (length ) ???

;; Structurally recursive function always receive an immediate
;; component of the current input for further processing.
;; Hence, if a function consumes a plain list and its recursive
;; does not consume the rest of the list, its definition
;; is not structural but generative. i.e. properly recursive 
;; algorithms consume newly generated input, which may or
;; may not contain components of the input. The new piece of data
;; represents a different problem that the given one, but still
;; a problem of the same general class of problems.



;; Section 26.3
;; Making Choices
;; -----------------------------------

;; A user cannot distinguish sort and quick-sort.
;; If we can develop a function using structural recursion
;; and equivalent one using general recursion ,wath should we do?

;; Using example, to understand this better. I present you: GCD
;; gcd : N[>=1] N[>=1] -> N
;; to find the greatest commond divisor of n and m

;; which to develop? no idea, lets do both.

;; We need a function that starts with the smaller of the two
;; and outputs the first number smaller or equal to ints input
;; that evenly divides both n and m

;; STRUCTURAL recursion using data definition of N[>=1]
(define (gcd-structural n m)
  (local ((define (first-divisor-<= i)
            (if (= i 1) 1
                (if (and (= (remainder n i) 0)
                         (= (remainder m i) 0)) i
                     (first-divisor-<= (sub1 i))))))
    (first-divisor-<= (min m n))))

;; for small numbers its fine, for larger like those
;;(gcd-structural 101135853 45014640)
;; it is large effort and takes quite a while.

;; -------------------------
;;    Exercise 26.3.1.
;; -------------------------
;; You can measure stuff with (time (f X))
;; Try it. 
;; With pleasure. 
; cpu time: 17281 real time: 19734 gc time: 0
; 177, hmm 20 seconds. 

;; Add (require-library "core.ss")
;; will evaluate faster but with less protection.

;; (require-library "core.ss")
;; Hmm it doesnt really work.



;; Some ancient dudes long time ago found out that
;; gcd is equal to the gcd of smaller and the remainder
;; of larger divided into smaller.

;; (gcd larger smaller) =
;; (gcd smaller (remainder larger smaller))

;; gcd-generative : N[>=1] N[>=1] -> N
;; to find the greatest common divisor of n and m
;; generative recursion: (gcd n m) = (gcd n (remainder n m) if (<= m n)
(define (gcd-generative n m)
  (local ((define (clever-gcd larger smaller)
            (if (= smaller 0) larger
                (clever-gcd smaller (remainder larger smaller)))))
    (clever-gcd (max m n) (min m n))))

;; clever-gcd is function based on generative recursion. 
;; answer now is almost instantaneous.


;; -------------------------
;;    Exercise 26.3.2.
;; -------------------------
;; Formulate informal answers to the four key questions for
;; gcd-generative.
;; a. Trivially solvable is one of the # is 0. 
;; b. Then the answer is the other number.
;; c. Generate new problem, exploiting that equation thingy.
;;    Yeah, Mr. White! Yeah, science! Magnets!
;; d.

;; -------------------------
;;    Exercise 26.3.3.
;; -------------------------
;; Time it. Will do.
;; cpu time: 0 real time: 0 gc time: 0
;; 177
;; Evaluate by hand. No deal.
;; Well I can see why I was asked to evaluate
;; by hand. Time is 0. We do 9 steps before we find
;; the solution. The time is not really 0. 

;; -------------------------
;;    Exercise 26.3.4.
;; -------------------------
;; Formulate a termination argument for gcd-generative.
;; Say what?



;; Bottom line - usually its easier to develop using 
;; structural recursion. To use generative, it requires deep
;; mathematical insight how to generate new, smaller problems.
;; To understand an algorithm, the generative step must be well
;; explained and even with a good explanation it might be difficult
;; to grasp the idea.

;; Best approach: start with structural recursion. If it turns out
;; to be too slow, explore the alternative using generative.


;; -------------------------
;;    Exercise 26.3.5.
;; -------------------------
;; Evaluate (quick-sort (list 10 6 8 9 14 12 3 11 14 16 2))
;; by hand.  How many recursive applications of append? 
;; Suggest a general rule for a list of length N.
;; No deal.

;; Evaluate (quick-sort (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))
;; See your rule and does it contradict with the first part?

;; -------------------------
;;    Exercise 26.3.6.
;; -------------------------
;; Add sort and quick-sort to the def win. Test and explore
;; how fast each works on various lists. Determine when it gets
;; advantageous to use one instead of another. What input
;; length is required?

;; Use the ideas of exercise 26.3.5 to create test cases.
;; Develop create-tests, a function that creates large 
;; test cases randomly. Then evaluate
;;
;; (define test-case (create-tests 10000))
;; (collect-garbage)
;; (time (sort test-case))
;; (collect-garbage)
;; (time (quick-sort test-case))
;; The uses of collect-garbage helps DrScheme to deal with large 
;; lists. 


;; Meh and I already got excited for learning something about
;; garbage collection and memory problems.
;; Still not doing this, this seems trivial, there are more 
;; things I need to learn first I think.

