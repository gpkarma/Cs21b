#lang racket
;; Author: Kristen Smith
;; What: Exercise 1.43
;; Date: Sunday, February 3, 2013

(define (square x) (* x x))

(define (inc x) (+ x 1))

(define (compose f g)
  (lambda (x) (f (g x))))
  
(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))















