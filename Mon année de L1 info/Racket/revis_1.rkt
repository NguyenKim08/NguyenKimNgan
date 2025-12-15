#lang racket

(define (revdup L)
  (if (empty? L)
      '()
      (cons (car L) (append (revdup (cdr L)) (list (car L) (car L))
      ))))
;has to make car L a list because append only works if add to a a list (also cons)


(revdup '(1 2 3 4))

(define (inverse L)
  (if (empty? L)
      '()
      (append (inverse (cdr L)) (list (car L)))
      ))

(inverse '(1 2 3 4))

(define (filtre L x y)
  (if (empty? L)
      '() ;base line here to be '()
      (if (and (<= x (car L)) (>= y (car L)))
          (cons (car L) (filtre (cdr L) x y))
          (filtre (cdr L) x y))))

(filtre '(2 1 6 4 8 3 9 7) 2 7)

(define (divisibles L n)
  (if (empty? L)
      '()
      (if (= (modulo (car L) n) 0)
          (cons (car L) (divisibles (cdr L) n))
          (divisibles (cdr L) n))))
(divisibles '(7 3 6 8 4 12) 3)

(define (permute L)
  (if (empty? L)
      '()
      (cons (cadr L) (cons (car L) (permute (cddr L))))
      ))

(permute `(a b c d e f))

(define (create n)
  (if (= n 0)
      '()
      (if (= n 1)
          (list 1)
          (append (create (- n 1)) (list n)
          ))))
(create 5)

(define (arr-aux L i)
  (if (empty? L)
      '()
       (cons i (arr-aux (cdr L) (+ i 1))) ;no additional list 0 here 
      ))

(define (arrange-list L)
  (arr-aux L 0))
(arrange-list '(1 2 -3 4 5 -6))

(define (regroupe L)
  (if (empty? L)
     '()
     (if (empty? (cdr L))
         (list (list car L))
         (list
          (cons (list (car L) (cadr L))
                (regroupe (cddr L))
       )))))

(regroupe '(a b c d e f)) ;sum wrong here bcz i cant regroupe if not pair

;for repeten, since we can't assemble, we need to split this function into half
;one is repeate each number n times
;other is to assemble it into a list

(define (makenx x n)
  (if (= n 0)
      '()
      (cons x (makenx x (- n 1)))))
(makenx 1 3)

(define (repeten L n)
  (if (empty? L)
      '()
      (append (makenx (car L) n) ;apply the need adjac func here, since its a
              ;list we use append
              ;then call the main function here for rest list
              (repeten (cdr L) n))))
(repeten '(1 2 3 4) 3)

(define (insere L x)
  (if (empty? L)
      (list x)
      (if (< (car L) x)
          (cons x L)
          (cons (car L) (insere (cdr L) x)
          ))))
(insere '(1 2 4 8 9 11 14) 10)


(define (min-sec L)
  (if (empty? L)
      (list '() '())
      (let ((m (sort L))) ;sort to make it croissant and then just add two in the list
        (list (car m) (cadr m))
        )))

(define (nfois L x n)
  (if (and (empty? L) (= n 0)) ;cond for base case
      #f
      (if (equal? (car L) x) ;if first list corresponds then n - 1 until 0
          (nfois (cdr L) x (- n 1))
          (nfois (cdr L) x n) ;if not just procedees with rest list until
          ;find the corresponds to x and then move back to case n-1
          )))

(define (position-aux x L i)
  (cond ((empty? L) #f)
        ((equal? (car L) x) i) ;has to use cond here because there's
        ;mismatched argus for if 
        (
         (position-aux x (cdr L) (+ i 1)))))

(define (position x L)
  (position-aux x L 0))


(position 3 '(1 2 3 4 5))

(define (intercale x L)
  (if (empty? L)
      (list x)
      (cons (car L) (cons x (intercale x (cdr L) ;missing one argu here between recur call
      )))))
(intercale 'x '(a b c d))

(define (zip L1 L2)
  (if (and (empty? L1) (empty? L2))
      '()
      (cons (list (car L1) (car L2)) (zip (cdr L1) (cdr L1)))))
;append is going to erase all () so cons here and since list here make (1 a) an element?
;we can use cons
(zip '(1 2 3) '(a b c d))

