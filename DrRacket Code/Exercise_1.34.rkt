#lang racket
;; Author: Kristen Smith
;; What: Exercise 1.34
;; Date: Friday 2-1-13


(define (f g)
  (g 2))

(define (square x) (* x x))

;; Explanation: The problem with trying (f f) is that it is like saying (f (g 2)) or (g (g 2)) ...
;; the interpreter needs a procedure to apply to the number 2 as input, not something
;; that just reduces to something that STILL, in the end, needs some kind of procedure.......