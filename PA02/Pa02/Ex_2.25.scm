#lang racket
;;@author Kristen Smith
;;@email ksmith22@brandeis.edu
;;@assignment pa02 exercise 2.25-car & cdr finger exercises
;;@date Thursday 2/21/13

;;Required to make using "nil" work in DrRacket
(define nil '())

;;The three lists (what would be entered to print them without any dots), and what would
;;prduce "7" if one types "(display <answer1, answer2,. etc>)" in the interpreter.
(define list1 (cons 1 (cons 3 (cons (cons 5 (cons 7 '())) (cons 9 '())))))
(define answer1 (car (cdr (car (cdr (cdr list1))))))

(define list2 (cons (cons 7 nil) nil))
(define answer2 (car (car list2)))

(define list3 (cons 1 (cons (cons 2 (cons (cons 3 (cons (cons 4 (cons (cons 5 (cons (cons 6 (cons 7 nil)) nil)) nil)) nil)) nil)) nil)))
(define answer3 (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr list3)))))))))))))




(define (write-line x)
  (display x)
  (newline))

         
         
        
      