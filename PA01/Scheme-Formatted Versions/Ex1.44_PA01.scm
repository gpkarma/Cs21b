#lang racket
;;Author: Kristen Smith (ksmith22@brandeis.edu)
;;Date: Friday 2/8/13
;;What: Exercise 1.44 from the textbook -- smoothing function

(define (square x) (* x x))
(define (inc x) (+ x 1))

;;from lecture slides
(define (compose f g)
  (lambda (x) (f (g x))))

;;Taken from lecture slides
(define (repeated fn n)
  (if (= n 1)
      fn
      (compose fn (repeated fn (- n 1)))))

;;Average of f(x - dx), f(x), and f(x + dx), assuming dx is very small.
(define (smooth fn dx)
  (lambda (x)
    (/ (+ (fn (+ x dx))
          (fn (+ x 0))
          (fn (- x dx)))
       3)))

;;Last part of exercise: to do the n-fold smoothed function, do:
;;((repeated (smooth fn dx) n) x)
;; in the interpreter