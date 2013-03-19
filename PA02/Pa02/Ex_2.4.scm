#lang racket
;;@author Kristen Smith
;;@email ksmith22@brandeis.edu
;;@assignment pa02 exercise 2.4 (p. 92): Representing pairs as procedures
;;@date Tuesday 2/19/2013

;; "verify that (car (cons x y)) yields x for any objectx x and y"

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

;; "What is hte corresponding definition of cdr?"

(define (cdr z)
  (z (lambda (p q) q)))


