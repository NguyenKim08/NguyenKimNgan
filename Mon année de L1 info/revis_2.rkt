#lang racket
(require racket/include)
(include "primitives.rkt")

(define (total L)
  (define (total2 n)
    (+ n))
  (map total2 L))

(define (moyenne L)
  (if (empty? L)
      '()
      (/ (foldr + 0 (total L) ) (length L))
      ))

;ex2
(define (remove_all e x)
  (if (empty? x)
      '()
      (if (equal? e (car x))
          (remove_all e (cdr x))
          (cons (car x) (remove_all e (cdr x)))
      )))
(remove_all 3 '(3 2 1 3 4 2 3 8))

(define (remove_first e x)
  (if (empty? x)
      '()
      (if (equal? e (car x))
            (cdr x)
            (cons (car x) (remove_first (cdr x) e))
            )))

(remove_first 3 '(3 2 1 3 4 2 3 8))

#|simple way, just reverse and delete the first one or we check if e exists in the restbefore delet it|#

(define (remove_last e x)
  (reverse (remove_first e (reverse x))))

(define (remove_last2 e x)
  (if (empty? x)
      '()
      (if (and (equal? e (car x)) (not (member e (cdr x)))) ;if equal to car x (first) and not in the rest
          (cdr x) ;return the rest
          (cons (car x) (remove_last2 e (cdr x)))))) ;if not do it again

#|to initialize index, i add an add-ons i for index|#
(define (first_equal_aux x y i)
    (if (or (empty? x) (empty? y))
        -1
        (if (equal? (car x) (car y))
            i
            (first_equal_aux (cdr x) (cdr y) (+ i 1)))
        ))
(define (first_equal x y)
  (first_equal_aux x y 0))

(first_equal '(2 13 7 8 5 2) '(1 4 7 3 5 11))

(define (powers x n)
  (if (= n 1)
      (list x)
      (append (powers x (- n 1)) (list (expt x n)))))

#|abs for absolute number|#
(define (dist_list x y)
  (if (empty? x)
      0
      (+ (abs (- (car x) (car y)))
         (dist_list (cdr x) (cdr y)))))

;when the list is size 2 by size 2


(define (diff_list2 x) 
  (if (empty? x)
      '()
      (cons
       (- (cadr (car x)) (car (car x))) ;the second element of the first group
       ; substract by the first element of the first group
       (diff_list2 (cdr x)))))

#|it's quite difficult to do this in one sitting so i splited it by two.
One would be counting the reccurrences of x in a list
Other would be making list of the number and its recurrences and we'd want to remove it too
For an easier life ofc|#
(define (nb-occ e x)
  (if (empty? x)
      0
      (if (equal? e (car x))
          (+ 1 (nb-occ e (cdr x)))
          (nb-occ e (cdr x)))))

(define (list-occ x)
  (cond ((empty? x) '()) ;asking if car x is still in the rest of the list
        ((member (car x) (cdr x)) (cons
                                   (list (car x)
                                         (nb-occ (car x) x))
                                   (list-occ (remove_all (car x) x)))) ;if yes, we count and remove it
        (else
         (cons (list (car x)
                     (nb-occ (car x) x)) ;if not just count
               (list-occ (cdr x)))))) ;and then we move on
;part 2

(define (leaf0 a)
  (if (arbre-vide? a)
      (arbre-vide )
      (if (feuille? a)
          (arbre 0 (arbre-vide ) (arbre-vide ))
          (arbre (racine a)
                 (leaf0 (fils-g a))
                 (leaf0 (fils-d a))))))

(define (map_tree fun a)
  (if (arbre-vide? a)
      (arbre-vide )
      (arbre (fun (racine a))
             (map_tree fun (fils-g a))
             (map_tree fun (fils-d a)))))

(define (filtre a x y)
  (if (arbre-vide? a)
      '()
      (if (and (>= (racine a) x) (<= (racine a) y))
          (cons (racine a) (append (filtre (fils-g a) x y)
                                   (filtre (fils-d a) x y)))
          (append (filtre (fils-g a) x y)
                  (filtre (fils-d a) x y)))))