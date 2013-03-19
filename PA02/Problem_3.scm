#lang racket
;;Kristen Smith (ksmith22@brandeis.edu)
;;PS2 -psych
;;

;;Problem #3--Modified (doctor-driver-loop) procedure
(define (doctor-driver-loop name)
  (newline)
  (write '**)
  (define (initial-list) (list '()))
  (let ((user-response (read)))
    (cond ((equal? user-response '(goodbye))
             (write-line (list 'goodbye name))
             (write-line '(see you next week)))
          (else (write-line (reply user-response (append (list user-response) (list (initial-list)))))
                (doctor-driver-loop name)))))

(define (reply user-response response-list-history)
  (cond ((fifty-fifty)
           (append (qualifier)
                   (change-person user-response)))
        ((prob 2 1)
            (cons ('(Earlier you said that )) (pick-random (change-person (cdr response-list-history))))) 
        (else (hedge)))) 