#lang racket
;TD3
(define L1 '(a b c))
(define L2 '(d e))

;ex1

;(list (cdr L1) L2)
;append will remove all the () and make it one ()
;cons will preserve the () of the first one but not the second one

;(append (cddr L1) (cdr L2))
;(append (cdr L1) (list (car L2)))

;ex2

(define (sec_em L)
  (if (empty? L)
      '()
      (car (cdr L))))

(define (long2 L)
  (if (empty? L)
      #f
      (if (= (length L) 2)
          #t
          #f
          )))


(define (nb_em L)
  (if (empty? L)
      0
      (+ 1 (nb_em (cdr L)))
      ))

(define (der_em L)
  (if (empty? (cdr L)) ;on doit assurer si il existe de cdr L ou pas
      (car L) ;sinon on retourne le premier elem
      (der_em (cdr L)
              ))
  )

(define (som_em L)
  (if (empty? L)
      0
      (+ (car L) (som_em (cdr L)))
      ))


(define (som_em_aux L res)
  (if (empty? L)
      res ;has to return res here 
      (+ (res (car L)) (som_em (cdr L))) ;no changes just add res
      ;not to the recur but the rest of the calcul
      ))
(define (som_em_2 L)
  (som_em_aux 0))

(define (no_sym L)
  (if (empty? L)
      '()
      (if (number? (car L))
          (cons (car L) (no_sym (cdr L)))
          (no_sym (cdr L))
          )))


(define (egal L e)
  (if (empty? L)
      0
      (if (equal? (car L) e)
          (+ 1 (egal (cdr L) e)) ;never forget to add if compare to sum
          (egal (cdr L) e)
          )))


(define (index L n)
  (if (or  (< n 0) (>= n (length L))) ;dont forget the if here when using or
      -1
      (if (= n 0) ;theres double cas d'arret
          (car L)
          (index (cdr L) (- n 1))
          )))

(define (insere L i x)
  (if (= i 1)
      (cons x L) ;the base start here determines the format
      (cons (car L) (insere (cdr L)(- i 1) x)) ;when not add at the start
      ;the object to be added has to be on the end
          ))

          
;Ex3

(define (som-prod L)
  (if (empty? L)
      (list 0 1) ;when multiply always base case 1
      (let ((m (som-prod (cdr L))))
        (list (
               (+ (car L) (car m) ;this is to address the 0 in (list 0 1)
               (* (car L) (cadr m)) ;this is for 1in (list 0 1)
               ))))))

;recur term vers
(define (som-prod3 L)
  (define (som-prod-aux L s p)
    (if (empty? L)
        (list 0 1)
        (som-prod-aux (cdr L) (+ (car L) s) (* (car L) p))))
  (som-prod-aux L 0))

;another combined form

;TP3

(define (nbinf L x)
  (if (empty? L)
      0
      (if (< (car L) x)
          (+ 1 (nbinf (cdr L) x))
          (nbinf (cdr L) x))
      ))


(define (som-carr-list L)
  (if (empty? L)
      0
      (if (number? (car L))
          (+ (* (car L) (car L)) (som-carr-list (cdr L)))
          (som-carr-list (cdr L))
          )))


(define (remplace L u v)
  (if (empty? L)
      '()
      (if (equal? (car L) u) ;compare here 
          (cons v (remplace (cdr L) u v)) ;cons sum to add in but also
          ;never forgets add all the argu theycompare/add
          (cons (car L) (remplace (cdr L) u v))
          )))

(define (remove-last L)
  (if (empty? L)
      '()
      (cons (car L) (remove-last (cdr L)))))

;cons (car L) is to show that we only take car L and not cdr L

;(define (binaire n)
 ; (if (>= n 1)
    ;  (if (= (modulo n 2) 0) ;check odd or even 
      ;    (list
       ;    (append (binaire  (quotient n 2)) (list 0)) ;append to add
           ;to the right side here and recur on quo to find the binary
        ;   (append (binaire (quotient n 2)) (list 1))
         ;  ))))
;Ex4-TD 3
(map (lambda (x) (* x x)) (list 1 2 3 4))

(define (carres L) ;-> fonction overall 
  (define (carre n) ; -> fonction qui calcul est stocké
    (* n n )) ;-> calcul/transformation
  (map carre L)) ;-> applique map avec fonction stocké
(carres '(1 2 3 4))

(define (somme-carre L)
  (foldr + 0 (carres L)))

(somme-carre '(1 2 3 4))

(define (even x) ;si il n'existe pas fun? de base, crees-en 1
  (if (even? x)
      x
      0))
(define (somme-pairs L)
  (foldr + 0 (map even L))) ;-> applique à foldr + cas de base et map

(define (odd x)
  (if (odd? x)
      x
      0))

(define (produit-pairs L)
  (foldr * 1 (map odd L)))

;map : applique une fonction à chaque élement d'une liste
;ou plusieurs listes et retourne nouvelle liste avec les résultats
;(map fonction liste) -> (map (lambda (x) (* x x)) '(1 2 3 4))
;; => '(1 4 9 16)



;foldr : réduit une liste à une seule valeur en appliquant une fonction
;combinant un élement de la liste et accumulateur
; (foldr fonction base) -> (foldr (lambda (x acc) (cons (* x x) acc)) '() '(1 2 3))
;; => '(1 4 9)