#lang racket
;;Kristen Smith (ksmith22@brandeis.edu)
;;PS2 - Psych, Problem #2

;;Problem #2--
;;When (change-person phrase) is modified to include the pairs (you i) and (are am)
;;into the middle of the list, typing "(change-person '(you are not being very helpful to me))" into the interpreter
;;still returns "(you are not being very helpful to you)".  "you" and "are" do, however,
;;change to "i" and "am" when the pairs (you i) and (are am) are added to the beginning
;;of the list in the (change-person) procedure; but this leaves the "me" as "i" at the 
;;end, so "(me you)" has to be added to the beginning of the procedure's list as well.
;;So (change-person) becomes:
(define (change-person phrase)
  (many-replace '((i you) (you me) (me you) (you i) (are am) (am are) (my your))
                phrase))

;;The bug/problem in the (replace) procedure, with (you i) (are am), etc, added
;; to the middle or end of the list of pairs, instead of the way as written
;;above, is that, because the (else) clause always builds/constructs a pair/list
;;with the (car) of the phrase (--i.e. with "you," in this case) is that the
;;rest of the phrase ("are not being very helpful to me") is always being
;;added onto that first, unchanged word. So if the pairs to change the
;;first/last pronouns of the phrase are not both at the beginning of the 
;;replacement-pairs list, then (change-person) does not work properly.  
