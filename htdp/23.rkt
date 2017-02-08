;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |23|) (read-case-sensitive #t) (teachpacks ((lib "gui.ss" "teachpack" "htdp") (lib "graphing.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "gui.ss" "teachpack" "htdp") (lib "graphing.ss" "teachpack" "htdp")))))
;;  ---------------------------
;;          Section 23
;; -----------------------------

;; Mathematical examples

;; Applying mathematics to real-world problems
;; requires that programs implement mathematical functions
;; Mathematics is a great starting point for practicing
;; programming with functions and, more generally,
;; for creating abstract functions

;; The first section covers sequences and series, a key element
;; of mathematics. The second section discusses integration,
;; which relies heavily on series. The third section introduces
;; function differentiation.

;; Let's hope that its possibe to get through this one without
;; the use of lambda or any advanced stuff which is ahead of me.


;; 23.1 Sequences and series

;; sequences = progressions of numbers

;; series is the sum of a sequence.
;; in the case of
;; infinite sequences, we often just consider a finite
;; portion of the sequence.


;; -------------------------
;;    Exercise 23.1.1.
;; -------------------------

;; Use local to create series-local from series-even and series-odd
;; Show with a hand evaluation that (series-local make-even) is equivalent
;; to series-even

;; make-even : N  ->  N[even]
;; to compute the i-th even number
(define (make-even i)
  (* 2 i))
            	
;; make-odd : N  ->  N[odd]
;; to compute the i-th odd number
(define (make-odd i)
  (+ (* 2 i) 1))

;; series-even : N  ->  number
;; to sum up the first

;; n even numbers
(define (series-even n)
  (cond
    [(= n 0) (make-even n)]
    [else (+ (make-even n) 
	     (series-even (- n 1)))]))	
     	
;; series-odd : N  ->  number
;; to sum up the first

;; n odd numbers
(define (series-odd n)
  (cond
    [(= n 0) (make-odd n)]
    [else (+ (make-odd n)
	     (series-odd (- n 1)))]))

;; series-local : N (N -> number) -> number
;; to make series given the sequence (term)
(define (series-local n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (local 
            ((define a-first (a-term n))
             (define a-rest (series-local (- n 1) a-term)))
            (+ a-first a-rest))]))

;(check-expect (series-even 5) (series-local 5 make-even))
;(check-expect (series-odd 4) (series-local 4 make-odd))

;; Evaluation by hand:

;; series-even
;; (series-even 2) =
;; (= 2 0) -> false =
;; (+ (make-even 2)
;;    (series-even (- 2 1))) ->
;; (+ 4 (series-even 1)) ->
;; (+ 4 
;; (= 1 0) -> false =
;; (+ (make-even 1)
;;    (series-even (- 1 1))) =
;; (+ 4 2 (series-even 0) ->
;; (= 0 0) -> true
;; (+ 4 2 (make-even 0)) =
;; (+ 4 2 0) =
;;  6

;; series-local
;; (series-local 2 make-even) =
;; (= 2 0) -> false =
;; (a-first_0 = (make-even 2)) -> 4
;; (a-rest_0 = (series-local (- 2 1) make-even) ->
;; (series-local 1 make-even) ->
;; (= 1 0) -> false 
;; (a-first_1 = (make-even 1) -> 2
;; (a-rest_1 = (series-local (- 1 1) make-even) ->
;; (series-local 0 make-even) ->
;; (= 0 0) -> true -> (make-even 0) -> 0 =
;; (+ a-first0 (+ a-first1 a-rest1)) ->
;; (+ 4 (+ 2 0)) =
;; 6


;; 23.2. Arithmetic Sequences and Series


;; In an arithmetic sequence a0,a1,a2,....,an,an+1...
;; each successort term an+1 is the result of adding a fixed constant
;; to an.

;; Example, matched up with the natural numbers:
;; Index:               0  1  2  3  4 ....
;; Arithmetic Sequence: 8 13 18 23 ...

;; Here the starting point is 3 and the constant is 5. From these two
;; facts, called starting point and summand, respectively, all other
;; terms in the sequence can be determined.

;; -------------------------
;;    Exercise 23.2.1.
;; -------------------------
;; Develop the recursive function a-fives, which
;; consumes a natural number and recursively determines
;; the corresponding term in the above series

;; a-fives : N -> number
;; where N is a natural number
;; to determine the Nth term in series
(define (a-fives n)
  (cond
    [(= n 0) (+ 3 5)]
    [else (+ 5 (a-fives (sub1 n)))]))

;(check-expect (a-fives 4) 28)

;; -------------------------
;;    Exercise 23.2.2.
;; -------------------------
;; Develop the NON-RECURSIVE function a-fives-closed.
;; It consumes a natural number and determines the corresponding
;; term in the above series. 
;; Note: A non-recursive function sometimes is called a closed form


;; a-fives-closed : N -> number
;; where N is a natural number
;; to determine the Nth term in series
(define (a-fives-closed n)
  (+ (* (add1 n) 5) 3))

;(check-expect (a-fives-closed 5) 33)


;; -------------------------
;;    Exercise 23.2.3.
;; -------------------------
;; Use series to determine the sum of 
;; the a-fives sequence for the bounds 3 7 and 88
;; Can an infinite arithmetic series have a sum?

;(series-local 3 a-fives-closed) = 62
;(series-local 7 a-fives-closed) = 204
;(series-local 88 a-fives-closed) = 20292
;; No, infinite arithmetic series can not have a sum,
;; the code would never terminate. Entirely other case
;; would be if we just looked at a portion of infinite series.

;; -------------------------
;;    Exercise 23.2.4.
;; -------------------------
;; Develop the function seq-a-fives, which consumes a natural
;; number n and creates the sequence of the first n terms according
;; to a-fives or a-fives closed.

;; seq-a-fives : N -> (listof number)
;; to create a list of first n terms in a sequence
(define (seq-a-fives n)
  (build-list n a-fives-closed))

;(check-expect (seq-a-fives 4) '(8 13 18 23))

;; -------------------------
;;    Exercise 23.2.5.
;; -------------------------
;; Develop arithmetic-series. The function consumes
;; two numbers: start and s. Its result is a function that
;; represents the arithmetic series whose starting point is start
;; and whose summand is s. For example:
;; (arithmetic-series 3 5) -> a-fives 
;; (arithmetic-series 0 2) produces a function that represents
;; the series of even numbers

;; arithmetic-series : number number -> (N -> number)
;; to create an arithmetic series, consumes starting point
;; and summand respectively
(define (arithmetic-series startpt summand)
  (local
    ((define (arithmeticSeries n)
       (+ (* (add1 n) summand) startpt)))
    arithmeticSeries))

;(define fives-again (arithmetic-series 3 5))
;(check-expect  (fives-again 25) (a-fives 25))





;; 23.3. Geometric Sequences and Series


;; In geometric sequence each successor term Gn+1 is the result
;; of multiplying a fixed constant with Gn.

; Example, matched up with natural numbers:

;; Index:                  0  1  2  3   4   ...
;; Geometric Sequence:     3 15 75 375 1875 ...

;; Here the starting point is 3 and the constant is 5. From these,
;; called starting point and factor, respectively, every other term
;; in the sequence can be determined.

;; -------------------------
;;    Exercise 23.3.1.
;; -------------------------
;; Develop the recursive function g-fives
;; which consumes a natural number and recursively determins the
;; corresponding term in above geometric sequence.


;; g-fives : N -> number
;; where N is a natural number
;; to determine the Nth term in series
(define (g-fives n)
  (cond
    [(= 0 n) (+ (* n 5) 3)]
    [else (* 5 (g-fives (sub1 n)))]))
   
;(check-expect (g-fives 4) 1875)

;; -------------------------
;;    Exercise 23.3.2.
;; -------------------------
;; Develop the NON-RECURSIVE function g-fives-closed.
;; It consumes a natural number and determines the corresponding
;; term in the above geometric series. 
;; Note: A non-recursive function sometimes is called a closed form


;; g-fives-closed : N -> number
;; where N is a natural number
;; to determine the Nth term in series
(define (g-fives-closed n)
  (cond
    [(= 0 n) 3]
    [else (* 3 (expt 5 n))]))

;(check-expect (g-fives-closed 4) 1875)


;; -------------------------
;;    Exercise 23.3.3.
;; -------------------------
;; Develop the function seq-g-fives, which consumes a natural
;; number n and creates the sequence of the first n terms according
;; to g-fives or g-fives-closed.

;; seq-g-fives : N -> (listof number)
;; to create a list of first n terms in a sequence
(define (seq-g-fives n)
  (build-list n g-fives-closed))

;(check-expect (seq-g-fives 5) '(3 15 75 375 1875))

;; -------------------------
;;    Exercise 23.3.4.
;; -------------------------
;; Develop geometric-series. The function consumes
;; two numbers: start and s. Its result is a function that
;; represents the arithmetic series whose starting point is start
;; and whose factor is s. For example:
;; (geometric-series 3 5) -> g-fives / g-fives-closed


;; geometric-series : number number -> (N -> number)
;; to create a geometric series function, consumes starting point
;; and factor respectively
(define (geometric-series startpt factor)
  (local ((define (geometricSeries n)
            (cond
              [(= 0 n) startpt]
              [else (* startpt (expt factor n))])))
    geometricSeries))

;(define g-fives-here (geometric-series 3 5))
;(check-expect  (g-fives-here 15) (g-fives 15))


;; -------------------------
;;    Exercise 23.3.5.
;; -------------------------
;; Use series to determine the sum of 
;; the g-fives sequence for the bounds 3 7 and 88
;; Can an infinite geometric series have a sum?

;(series-local 3 a-fives-closed) = 375
;(series-local 7 a-fives-closed) = 234375
;(series-local 88 a-fives-closed) = 96935228033557930648993206101948771902243606746196746826171875
;; Same thing applies. Infinite? No. Portion? Sure.

;; Taylor series

;; Mathematical constants like pi or e or functions like
;; sin, cos or log are difficult to compute. Since these
;; functions are important for many daily engineering applications,
;; mathematicians have spent a lot of time and energy looking for
;; better ways to compute these functions. One method is to replace a
;; function with its Taylor series, which is, roughly speaking
;; an infinitely long polynomial.

;; A Taylor series is the sum of a sequence of terms.
;; In contrast to arithmetic and geometric sequences, the terms of a Taylor
;; series depend on two unknowns: some variable X and the position
;; i in the sequence. Here is the Taylor series for exponential function:

;; e^X = 1 + x/1! + x^2/2! + x^3/3! + ......

;; The key to computing a Taylor series is to formulate
;; each term in the underlying sequence as a function of
;; x and its position i. In our running example, the Taylor sequence
;; for the exponential function has the shape: x^i/i!


;; assuming a fixed, X, here is an equivalent Scheme definition:

(define (e-power x)
  (local ((define (e-taylor i)
          (/ (expt x i) (! i)))
          (define (! n)
            (cond
              [( = n 0) 1]
              [else (* n (! (sub1 n)))])))
    (series-local 10 e-taylor)))



;; -------------------------
;;    Exercise 23.3.6.
;; -------------------------
;; Replace 10 by 3 in the definition of e-power and 
;; evaluate (e-power 1) by hand. Show only those lines
;; that contain new applications of e-taylor to a number.

;; (e-power 1) =
;; (+ (/ (expt 1 3) (! 3))
;;    (+ (/ (expt 1 2) (! 2))
;;       ( + (/ (expt 1 1) (! 1))
;;           (/ (expt 1 0) (! 0))))) =
;; (+ sth sth sth 1)


;; The results of e-power are fractions with large numerators and
;; denominators. In contrast Scheme's built in exp function produces
;; an inexact number. We can turn exact fractions into inexact numbers
;; with the following functions:

;;      exact->inexact : number [exact] -> number [inexact]

;; Test the function and add it to e-power's body. Then compare
;; the results of exp and e-power. Increase number of items in the
;; series until the difference in the results is small.

(define (e-power2 x)
  (local ((define (e-taylor i)
          (/ (expt x i) (exact->inexact (! i))))
          (define (! n)
            (cond
              [( = n 0) 1]
              [else (* n (! (sub1 n)))])))
    (series-local 10 e-taylor)))

;(e-power 1)
;(e-power2 1)


;; -------------------------
;;    Exercise 23.3.7.
;; -------------------------
;; Develop the function ln, which computes
;; the Taylor series for the natural logarithm
;; The mathematical definition of the series is:

; ln(x) = 2*[((x-1)/(x+1))+1/3*((x-1)/(x+1))^3+1/5*((x-1)/(x+1))^5...]

;; This Taylore series has a value for all x that
;; are greater than 0

;; ln : N -> x
;; where N > 0
;; to compute the Taylor series for the natural logarithm
(define (ln x)
  (local ((define (lognat i)
            (local ((define y (make-odd i)))
            (cond
              [(= 0 i) (/ (- x 1) (+ x 1))]
              [else 
               (* (/ 1 y) (exact->inexact (expt (/ (- x 1) (+ x 1)) y)))]))))
    (* 2 (series-local 25 lognat))))

;; I know there is another way to define ln, using log:

(define (ln2 x)
  (/ (log x) (log (e-power 1))))

;; DrScheme provides log. Compare the results for
;; ln and log. Use exact->inexact so its easier to compare.

;; Weird, both of them seems to be off.
;; ln goes imprecise at the last digit,
;; ln2 even sooner - at the 8th digit.
;; Oh well, for learning purposes it will do I guess, as I do not
;; have all the right answers to check my results against.

;; As for that exact->inexact thingy, I have absolutely no idea
;; where the heck to put it.


;; -------------------------
;;    Exercise 23.3.8.
;; -------------------------
;; Develop the function my-sin, which computes the Tylor series
;; for sin, one of the trigonometric functions. The Taylor series
;; is defined as follows:

;;    sin(x) = x/1! - x^3/3! + x^5/5! - x^7/7! ...

;; it is defined for all x.

;; Hint: The sign of a term is positive if the index is even and negative otherwise
;; Mathematicians compute (- 1)^i to determine the sign. 
;; Programmers can use "cond" instead.


;; I say, screw the cond. :D

;; sin : x -> number
;; to compute the Taylor series for sin.
(define (sin2 x)
  (local
    ((define (! i)
       (cond
         [(= 0 i) 1]
         [else (* i (! (sub1 i)))]))
     (define (get-sin y)
       (local ((define z (make-odd y)))
         (cond
           [(= 0 y) x]
           [else (* (expt -1 y) (/ (expt x z) (! z)))]))))
    (series-local 100 get-sin)))

;; Mkei, seems to be consistent with pre-defined sin function
;; in DrRacket, but for it not to break down at larger values, 
;; actually it breaks down when going over 75 degrees with 100 values.
;; i.e. for 360, 300 doesnt cut it, 1000 does, but it takes ages to compute. 
;; Dunno how its implemented in Racket.
;; Will have to find it out later.


;; -------------------------
;;    Exercise 23.3.9.
;; -------------------------
;; THE P.I.E.
;; Mathematicians have used series to determine the value of
;; pi for many centuries. Here is the first such sequence, discovered
;; by Gregory (1638-1675)  ... Ooh the infamous Gregory. Yeah, 
;; definitely know that guy.

;;      pi = 4*[1-1/3+1/5-1/7......]

;; Define the function greg, which maps a natural number to the
;; corresponding term in this sequence. Then use series to 
;; determine the approximations of the value of pi.
(define (get-greg x)
  (local
    ((define oddy (make-odd x)))
    (* (expt -1 x) (/ 1 oddy))))

(define pi1 (* 4 (series-local 25 get-greg)))
(define pi2 (* 4 (series-local 75 get-greg)))
(define pi3 (* 4 (series-local 125 get-greg)))
(define pi4 (* 4 (series-local 625 get-greg)))


;; Note: The approximation improves as we increase the number of
;; terms in the series. Unfortunately it is not practical to compute
;; pi with this definition. ;(




;; 23.4 The Area Under a Function

;; Determining the area under the graph of a function for
;; some specific interval is called integrating a function.

;; A general integration function must consume three inputs:
;; a, b and the function f. The fourth part, the x axis, is implied.
;; This suggests the following contract:

;; integrate : (number->number) number number -> number
;; to compute the area under the graph of f between a and b
(define (integrate-me f a b) ...)

;; Kepler suggested one simple integration method. It consists of
;; three steps:
;; 1. divide the interval into two parts: [a,(a+b/2) and [(a+b/2),b]
;; 2. compute the area of each trapezoid, and
;; 3. add the two areas to get an estimate integral.

;; -------------------------
;;    Exercise 23.4.1.
;; -------------------------
;; Develop the function integrate-kepler. It computes the area under
;; the curve of some functions f graph between left and right, using
;; Keplers rule.
;; integrate-kepler : (number->number) number number -> number
;; to compute area under the curve using Keplers' rule

;; Had no idea how to compute this, but, lucky me, some1 had written
;; the solution.

(define (integrate-kepler f a b)
  (* (+ (f a)
        (* 4 (f (/ (+ a b) 2 )))
        (f b))
     (/ (- b a) 6)))

(define (square x)
  (* x x))
(define (one x)
  1)

;(check-expect (integrate-kepler one 0 1) 1)
;(check-expect (integrate-kepler square 0 1) 1/3)

;; I have no idea how this was done, looks like there
;; some mathematical rewriting of the forumla has been done.
;; I'll try to solve next one on my own at least.


;; -------------------------
;;    Exercise 23.4.2.
;; -------------------------
;; Develop the function integrate.
;; It computes the area under some the
;; graph and some function f between left and
;; right using the rectangle-series method.

(define (integrate f a b)
  (local ((define counter 0)
          (define (integrate-me f a b R i)
            (local (
                    (define width (/ (- b a) R))
                    (define step (/ width 2))
                    (define middle (+ a (* i width) step))
                    (define area (* width (f middle)))
                    )
              (cond
                [(= (sub1 R) i) 0]
                [else (+ area
                         (integrate-me f a b R (add1 i)))]))))
    (integrate-me f a b R counter)))

;; I'm sure its not the most elegant way, but, hey, it gets the job
;; done.

;; Compare results with integrate-kepler.
;(check-within (integrate-kepler square 0 1) (integrate square 0 1) 0.001)
;; Hmm, seems that kepler's method is quite good, actually better
;; when R is low, i.e. under 1000 or so

;; Make R a top-level constant. 
;; R : number of rectangles to approximate integral
(define R 99)
;; What is a top-level constant?
;; Test integrate on sin and increase R gradually from 10 to 10000
;; What happens to the result?
;(integrate sin 4 10)
;; R = 10  #i0.1886771950669043
;; R = 100 #i0.21657220229159807
;; R = 1000 #i0.1886771950669043
;; R = 5000 #i0.1860801404226106
;; R = 10000 #i0.1857541726132321
;; Not sure why the one with R around 100 is off...



;; 23.5 The Slope of a Function 


;; Again, complicated. Consumes f and produces f'

;; If the point of interest has coordinate x,
;; the two points to compute the slope are
;; (x, f(x-epsilon)) and (x, (f(x+epsilon)
;; Hense the slope of the line is:
;;   f(x+e)-f(x-e)/2e
;; rise over run.

;; -------------------------
;;    Exercise 23.5.1.
;; -------------------------

;; The equation for a line is:
;;      y(x) = a*x + b
;; Straightforward translation into Scheme:
;(define (y x)
;  (+ (* a x) b))
;; To obtain a concrete line we must replace a and b with numbers

;; Use graphing.ss here, to graph following lines.
;; Syntax: graph-line : line color

;(define (y1 x)
;  (+ (* 1 x) 4))
;(define (y2 x)
;  (+ (* -1 x) 4))
;(define (y3 x)
;  (+ (* 1 x) 10))
;(define (y4 x)
;  (+ (* -1 x) 10))
;(define (y5 x)
;  (+ (* 0 x) 12))
;(graph-line y1 'blue)
;(graph-line y2 'purple)
;(graph-line y3 'pink)
;(graph-line y4 'gray)
;(graph-line y5 'green)

;; -------------------------
;;    Exercise 23.5.2.
;; -------------------------
;; Develop a function line-from-point+slope
;; consumes a posn (the point) and a number (the slope)
;; Produces a function that represents the line, like in
;; exercise 23.5.1.
(define (line-from-point+slope point slope)
  (local (
          (define b (- (posn-y point) (* slope (posn-x point))))
          (define (func1 x)
            (+ (* slope x) b)))
    func1))

;(define myfunc1 (line-from-point+slope (make-posn 0 4) 0))
;(graph-line myfunc1 'red)

;; -------------------------
;;    Exercise 23.5.3.
;; -------------------------
;; Use the operation graph-fun in the teachpack 
;; graphing.ss to draw the mathematical function 
;; y(x) = x^2 - 4*x + 7

(define (y6 x)
  (+ (- (expt x 2) (* 4 x)) 7))


;(graph-fun y6 'red)

;; Suppose we wish to determine the slope at x = 2
;; Pick an epsilon > 0 and determine the slope that
;; goes through 2 points with the above formula.
(define (slope x epsilon1 f)
  (/ (- (f (+ x epsilon1)) (f (- x epsilon1))) (* 2 epsilon1)))

;; Compute the line with line-from-point+slope
;; and use graph-line to draw it into the same
;; coordinate system as y. 

;(define point 3)
;(define epsilon1 10)

;(graph-line (line-from-point+slope (make-posn point (y6 point)) (slope point epsilon1 y6)) 'blue)

;; Repeat the process with epsilon/2 and epsilon/4

;(graph-line (line-from-point+slope (make-posn point (y6 point)) (slope point (/ epsilon1 2) y6)) 'purple)
;(graph-line (line-from-point+slope (make-posn point (y6 point)) (slope point (/ epsilon1 4) y6)) 'green)

;; Hmm all lines overlap. What am I missing?

;; If our goal is to define the differential operator as a Scheme function,
;; we can approximate it by setting epsilon to a small number and
;; by translating the mathematical formula into a Scheme expression:

;; d/dx : (num -> num) -> (num -> num)
;; to compute the derivative function of f numerically
(define (d/dx f)
  (local ((define (fprime x)
            (/ (- (f (+ x epsilon)) (f (- x epsilon)))
               (* 2 epsilon)))
          (define epsilon 0.5 ))
    fprime))

;; Note that d/dx consumes and produces functions -- just like the differential
;; operator in mathematics.

;; The differential operator computes the function f' from some function f.
;; The former computes the slope of f for any x. For straight lines,
;; the slope is always known. Hence a function that represents a straight
;; line is an ideal test case for d/dx. Let us consider

(define (a-line x)
  (+ (* 3 x) 1))

;; Evaluation by hand blah blah....
;; Consider (f x) as numbers, and result of
;; (d/dx a-line) always returns 3 - the slope.

;; In general, however, the answer will depend on epsilon
;; and will not be precise.

;; -------------------------
;;    Exercise 23.5.4.
;; -------------------------
; Pick a small epsilon and use d/dx to compute the slope of
; y(x) = x^2 - 4*x + 7 at x=2. How does it compare to 23.5.3.?

;; Wat? I already computed the slope that way. It will be exactly
;; the same.


;(define  sloppy1 (d/dx y6))
;(equal? (slope 2 0.5 y6) (sloppy1 2))


;; -------------------------
;;    Exercise 23.5.5.
;; -------------------------
;; D f line-from-two-points. Consumes p1 p2, Result - function.
;; (line-from-two-points) : posn1 posn2 -> (x -> x)
;; to compute the function by using 2 points.
(define (line-from-two-points point1 point2)
    (local (
          (define rise (- (posn-y point2) (posn-y point1)))
          (define run (- (posn-x point2) (posn-x point1)))
          (define slope (cond
                          [(zero? run) (error "Thats aint no function I know of. Divide by zero again! I dare you, I double dare you, motherfucker! Divide by zero one more god damn time!.")]
                          [else (/ rise run)]))
          (define b (- (posn-y point1) (* slope (posn-x point1))))
          (define (func1 x)
            (+ (* slope x) b)))
    func1))

;(define a-line2 (line-from-two-points (make-posn 2 7) (make-posn 3 10)))
;(equal? (a-line2 5)
;        (a-line 5))

;(graph-line (line-from-two-points (make-posn 2 7) (make-posn 3 10)) 'blue)
;(graph-line a-line 'green)


;; Task: If errors are possible, fix it!

;; Divison by zero handled by inappropriate error message
;(graph-line (line-from-two-points (make-posn 3 5) (make-posn 3 8)) 'green)


;; -------------------------
;;    Exercise 23.5.6.
;; -------------------------

;; Compute the following function at x = 4 and e set to 2 1 and 0.5

(define pointzy 4)
(define pointzy2 14)
(define eps1 2)
(define eps2 1)
(define eps3 .5)

(define (f7 x)
  (+ (* 1/60 (* x x x))
     (* -1/10 (* x x))
     5))

;(slope pointzy eps1 f7)
;(slope pointzy eps2 f7)
;(slope pointzy eps3 f7)

;(slope pointzy2 eps1 f7)
;(slope pointzy2 eps2 f7)
;(slope pointzy2 eps3 f7)

