#lang racket

(define (secondem L)
  (car (cdr L)))

(define (long L)
  (= (length L) 2))

(define (long-list L)
  (if (empty? L)
      1
      (+ 1 (length (cdr L))
         )))
;Using length to know the length of the list 
;also add1 in the begining for car L

(define (last-elem L)
  (if (null? (cdr L))
      (car L)
      (last-elem (cdr L))))

(last-elem '(1 2 3))

(define (somlist L)
  (if (empty? (cdr L))
      (car L)
      (+ (car L) (somlist (cdr L)))
      ))
(somlist '( 1 1))

(define (somlist_aux L res)
  (if(null? L)
     res
     (somlist_aux (cdr L) (+ res (car L)))
     ))

(define (sym L)
  (if(empty? L)
     '()
     (if (integer? (car L))
         (cons (car L) (sym (cdr L)))
         (sym (cdr L))
         )))
         
(sym '(1 & 2 $))

(define (egal L e)
  (if(empty? L)
     '()
     (if (equal? (car L) e)
         (egal (cdr L) e)
         (cons (car L) (egal (cdr L) e))
         )))
(egal '(1 2 2 4 5) 2)

(define (index L n)
  (cond
    [(or (< n 0) (>= n (length L))) #f]     ; invalid index
    [(= n 0) (car L)]                       ; base case
    [else (index (cdr L) (- n 1))]))        ; recursive step

;;if index from the end
;(define (index-from-end L n)
  ;(index L (- (length L) 1 n)))
; length - n

(define (insere L i x)
  (if (= i 0)
      (cons x L)
      (cons (car L) (insere (cdr L) (- i 1)x))
      ))
;;i - 1 to move up in cdr L while added car L
;;if i = 0 meaning the index is the first one so just add x in L before car L

(insere '(1 2 3) 1 8)

(define (somprod L)
  (if (null? L)
      (list 0 1) ;; x + 0 = x but x * 1 = x so it wont change
      ;; the result when operation unwinds to the base case
      (list (+ (car L) (car (somprod (cdr L))))
      (list (* (car L) (cadr (somprod (cdr L))))
      ))))
;;takes the box as exemple, we need to store 2 diff res in 2 places in the box
;;so car is the first for sum and cadr is the second first for *

;;(define (somprod-memo L)
  ;;(if (null? L)
      ;;(list 0 1)
      ;;(let* (
          ;;  [res (somprod (cdr L))]
          ;;  [first (car L)]
          ;;  ))
     ; (list(+ (first) (car (res))))
     ; (list(* (frist) (cadr (res))))
     ;  ))

;ex4

(define (carres L)
  (map (lambda (x) (* x x)) L)
  )
(carres '(1 2))

(define (somme-carres L)
  (foldr (lambda (x) (+ (* x x)) L)))
(somme-carres '(1 2))

