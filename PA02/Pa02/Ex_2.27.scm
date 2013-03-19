#lang racket
;; Kristen Smith (ksmith22@brandeis.edu)
;; What: PS02, Exercise 2.27
;; Date: 2/27/13

(define x (list (list 1 2) (list 3 4)))

(define (deep-reverse items)
  (list (append (cdr (car items)) (list (car (car items))))
          (append (cdr (car (cdr items))) (list (car (car (cdr items)))))))
  

