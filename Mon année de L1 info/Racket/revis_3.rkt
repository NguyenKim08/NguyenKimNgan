#lang racket

;Listes

;;ex1

(define (firsts L)
  (if (empty? L)
      0
      (if (= (car L) (cadr L))
          (+ 1 (firsts (cddr L)))
          (firsts (cddr L)))
          ))
(firsts '(1 1 1 2 3 4))