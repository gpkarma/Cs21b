#lang racket
;; Author: Kristen Smith
;; What: Book exercise 1.17
;; Date: Friday 2-1-2013
(define (double x) (+ x x))

(define (halve x) (/ x 2))

(define (even? x)
  (= (remainder x 2) 0))

(define (* a b)
    (cond ((= b 0) 0)
          ((even? b) (double (* a (halve b))))
          (else (+ a (* a (- b 1))))))

