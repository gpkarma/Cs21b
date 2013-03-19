#lang racket
;; Author: Kristen Smith (ksmith22@brandeis.edu)
;; What: PA_01 (Lunar Lander)
;; Date: 

;(define (update ship-state fuel-burn-rate)
;  (make-ship-state
;   (+ (height ship-state) (* (velocity ship-state) dt)) ; height (initial = 50 km)
;   (+ (velocity ship-state)
;      (* (- (* engine-strength fuel-burn-rate) gravity)
;         dt))                                           ; velocity
;   (- (fuel ship-state) (* fuel-burn-rate dt))))        ; fuel 
;  
;(define (lander-loop ship-state)
;  (show-ship-state ship-state)
;  (if (landed? ship-state)
;      (end-game ship-state)
;      (lander-loop (update ship-state (get-burn-rate)))))

(define (show-ship-state ship-state)
  (write-line 
    (list 'height (height ship-state)
          'velocity (velocity ship-state)
          'fuel (fuel ship-state))))

(define (landed? ship-state)
  (<= (height ship-state) 0))

(define (end-game ship-state)
  (let ((final-velocity (velocity ship-state)))
       (write-line final-velocity)
       (cond ((>= final-velocity safe-velocity)
               (write-line "good landing")
               'game-over)
             (else
               (write-line "you crashed!")
               'game-over))))

;(define (play)
;  (lander-loop (initial-ship-state)))

(define (ask-user ship-state) 
  (get-burn-rate))

;;NOTE: comment out to make re-definition of <get-burn-rate> work below for <constant-acc>
(define (get-burn-rate)
  (if (= (player-input) burn-key)
      1
      0))

(define (initial-ship-state)
  (make-ship-state 50       ; 50 km high
                   0        ; not moving (0 km/sec)
                   20))     ; 20 kg of fuel left

(define dt .98888888888)               ; 1 second interval of simulation
  
(define gravity 0.5)        ; 0.5 km/sec/sec
  
(define safe-velocity -0.5) ; 0.5 km/sec or faster is a crash

(define engine-strength 1)  ; 1 kilonewton-second

(define (player-input) 
  (char->integer (prompt-for-command-char " action: "))) 

(define burn-key 32)   ;space key

; You'll learn about the stuff below here in Chapter 2.
; For now, think of make-ship-state, height, velocity, and fuel
; as primitive procedures built in to Scheme.

(define (make-ship-state height velocity fuel)
  (list 'HEIGHT   height
        'VELOCITY velocity
        'FUEL     fuel))

(define (height state) (second state))
(define (velocity state) (fourth state))
(define (fuel state) (sixth state))

(define (second l) (cadr l))
(define (fourth l) (cadr (cddr l)))
(define (sixth l) (cadr (cddr (cddr l))))

; Users of DrScheme or DrRacket: add these for compatibility with MIT Scheme...
(define (write-line x)
  (display x)
  (newline))

(define (prompt-for-command-char prompt)
  (display prompt)
  (read-char))  

;;-----------------------------------------------------------------------;;
;;       Kristen's Code Below                                            ;;
;;-----------------------------------------------------------------------;;

;;Problem #1: Modified <update> procedure to take acocunt of max fuel-burn-rate = (/ x dt)
;;NOTE: comment this out, and uncomment the update procedure above when doing #8 or #10
(define (update ship-state fuel-burn-rate)
  (make-ship-state
   (+ (height ship-state) (* (velocity ship-state) dt)) ; height (initial = 50 km)
   (+ (velocity ship-state)
      (* (- (* engine-strength fuel-burn-rate) gravity)
         dt))                                           ; velocity
   (if (> fuel-burn-rate (/ (fuel ship-state) dt))
       (- (fuel ship-state) (* (/ (fuel ship-state) dt) dt))
       (- (fuel ship-state) (* fuel-burn-rate dt)))))   ; fuel -- if the fuel-burn-rate is larger than the max burn rate, use the max burn rate as the fuel-burn-rate

(define (full-burn ship-state) 1)

(define (no-burn ship-state) 0)

;; Problem #2: Modified (play) and lander-loop procedure to take a strategy as input
;; An example strategy may be: <ask-user> for the fuel-burn-rate, <full-burn>, etc.
(define (play strategy)
  (lander-loop (initial-ship-state) strategy))

;;NOTE: uncomment lander-loop above and comment ou tthis lander-loop when using the constant-acc strategy for #8 below
(define (lander-loop ship-state strategy)
  (show-ship-state ship-state)
  (if (landed? ship-state)
      (end-game ship-state)
      (lander-loop (update ship-state (strategy ship-state)) strategy)))

;; Problem #3: takes two strategies as arguments and returns a combination of them, 
;; which is a strategy itself -- i.e. to randomly choose either full-burn(1) or no-burn(0)
(define (random-choice strategy1 strategy0)
  (lambda (ship-state)
    (if (= (random 2) 0)
        (strategy1 ship-state)
        (strategy0 ship-state))))

;;Problem #4
(define (height-choice strategy0 strategy1 heightNumber)
  (lambda (ship-state)
    (if (>= (height ship-state) heightNumber)
        (strategy0 ship-state)
        (strategy1 ship-state))))

;;Problem #5
(define (choice strategy0 strategy1 g)
  (lambda (ship-state)
    (if (g ship-state)
        (strategy0 ship-state)
        (strategy1 ship-state))))

(define (random-choice2 strategy0 strategy1)
  (choice strategy0
          strategy1
          (lambda (ship-state) (= (random 2) 0))))

(define (height-choice2 strategy0 strategy1 heightNumber)
  (choice strategy0 
          strategy1 
          (lambda (ship-state) (> (height ship-state) heightNumber))))

;;Problem #6
(define (height-or-random-choice strategy0 strategy1 heightNumber)
  (choice (height-choice2 strategy0 strategy1 heightNumber) ;; strategy #1: call height-choice2 note: strategy0 must be no-burn for this to work
          (random-choice2 full-burn ask-user) ;; strategy #2: randomly choose between strategy0 and strategy1
          (lambda (ship-state) (> (height ship-state) heightNumber))))

;;Problem #8:
;;NOTE: change the definition of (dt) above to be .98999999999 or something approximate
;;This gives the fuel burn rate. Defines the burn-rate, or acceleration, to be the velocity divided by the time interval,
;;because <v = at> --> a = v / t. This will land the ship every time.
(define (constant-acc ship-state)
  (* -1 (/ (velocity ship-state) dt)))

;;(Prior version of #8 which does not work for problem #9 -- this strategy only works when
;;the height is specified to be 30 -- as in (play (height-choice2 no-burn constant-acc 30)).
;;With this, doing (play (height-choice2 no-burn constant-acc 20)) will not land the ship.
;(define (constant-acc ship-state)
;  (define (square x) (* x x))
;   (/ (square (velocity ship-state)) 
;      (* 2 (height ship-state))))

;;Problem #9: See 2 screen-shots in jpg format--show results of (play (height-choice2 no-burn constant-acc 20))
;;and (play (height-choice2 no-burn constant-acc 30)) ... Though my version of constant-acc for #8 (the first one)
;;makes it so that all the fuel is used up every time. Since that version of constant-acc landed the ship, however,
;;it is the one I have chosen to submit.  The second version may exemplify constant-acc 20 using less fuel than
;;constant-acc 30. 

;;Problem #10: Update modification #2
;;Uncomment definition below and comment out prior (update) procedure above to test.
;(define (update ship-state fuel-burn-rate)
;  (make-ship-state
;   (+ (height ship-state) (* (velocity ship-state) dt)) ; height (initial = 50 km)
;   (if (>= (- 1 fuel-burn-rate) 0)
;       (+ (velocity ship-state)
;          (* (- (* engine-strength fuel-burn-rate) gravity)
;             dt))                                           ; velocity
;       (+ (velocity ship-state)
;          (* (- (* engine-strength 1) gravity)
;             dt)))
;   (if (> fuel-burn-rate (/ (fuel ship-state) dt))
;       (- (fuel ship-state) (* (/ (fuel ship-state) dt) dt))
;       (- (fuel ship-state) (* fuel-burn-rate dt)))))

;;Problem #11: Implementation of modified update strategy (see above for #10) as a procedure
(define (optimal-constant-acc ship-state)
  (define (x)
    (- (* -1 (/ (velocity ship-state) dt))
       gravity))
  (if (> x 0)
      (- 1 x)
      (- 1 (- 0 x))))