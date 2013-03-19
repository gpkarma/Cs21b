#lang racket
;; Author: Kristen Smith (ksmith22@brandeis.edu
;; Date: Friday 2/8/13
;; What: Exercise 1.44 from the book (PA 01)

;; Analogous to the "1+" procedure from lecture slides
(define (inc x) (+ x 1))

;;Squares the input value <x>
(define (square x) (* x x))

;;from lecture slides
(define (compose f g)
  (lambda (x) (f (g x))))

;;Taken from lecture slides
(define (repeated fn n)
  (if (= n 1)
      fn
      (compose fn (repeated fn (- n 1)))))