#lang racket
;Kristen Smith (ksmith22@brandeis.edu)
;What: PA02, Ex 2.29
;Date: 2.28.13

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;;(a.)
;left-branch
;  (car (make-mobile 1 2))
;
;right-branch--(car (cdr (make-mobile 1 2)))
;
;branch-length--(car (make-branch))
;
;branch-structure--(car (cdr (make-branch)))

;;(b.)
