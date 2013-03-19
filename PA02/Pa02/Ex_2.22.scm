#lang racket
;;@author Kristen Smith
;;@email ksmith22@brandeis.edu
;;@assignment pa02 exercise 2.22 (p. 107): Bad implementations of square-list
;;@date Wednesday 2/20/2013

;;Required to make using "nil" work in DrRacket
(define nil '())

;;Ex 2.21--requires no "mapping"
(define (square-list items)
  (if (null? items)
      nil
      (cons (* (car items) (car items))
            (square-list (cdr items)))))

;;Using mapping
(define (square-list2 items)
  (map (lambda (x) (* x x)) items))

(define (square x) (* x x))

;;Ex 2.22--Note: the <iter> and <square-list> are separated out into
;;separate procedures
(define (iter things answer)
  (if (null? things)
      answer 
      (iter (cdr things)
            (cons (square (car things))
                  answer))))

(define (iter2 things answer)
  (if (null? things)
      answer
      (iter2 (cdr things)
            (cons answer
                  (square (car things))))))
  

(define (square-list3 items)
  (iter items nil))

(define (square-list4 items)
  (iter2 items nil))

;;A version of <iter> that actually works, where it repeatedly appends two LISTS
;;together, <answer> (the empty list), and a 1-item list always made up of the first
;;item to be squared (car things).Comment out iter2 and uncomment this
;;section to run it.

;(define (iter2 things answer)
;  (if (null? things)
;      answer
;      (iter2 (cdr things)
;            (append answer
;                  (list (square (car things)))))))


;EXPLANATION:

;The reason the 2 given versions of squar-iter do not work
;are that they continue to construct a NEW list every time
;<iter> recursively calls itself--so that, even when we are not
;adding items on the wrong "side" (visually) of the <nil> list,
;(<answer>, at first), when version #2 runs there are still
;all these extra parentheses because new lists keep getting
;constructed out of the old list while the procedure iterates. What we
;REALLY want to do is APPEND the lists together (so there aren't any
;extra parentheses when it is run...). See the version of
;iter above I wrote, which does work.