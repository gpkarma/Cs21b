#lang racket
(define (inc x) (+ x 1))

(define (square x) (* x x))

(define (compose x n)
  (cond (= x (+ x n) square x)
      (else (compose (square (inc x)) n))))