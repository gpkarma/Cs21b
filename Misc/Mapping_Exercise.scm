#lang racket

(define nil '())

;(define (scale-list items factor)
;  (if (null? items) 
;      0
;      (cons (* (car items) factor)
;            (scale-list (cdr items) factor))))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (scale-list items factor)
  (map (lambda (x) (* x factor)) items))


       