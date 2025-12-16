#lang racket
(require racket/include)
(include "primitives.rkt")

(define a1 '(4 (2 () ())
               (8 (0 () ()) (6 () ()))))
(define a2 '(3 (5 () ()) (7 () ())))

#|Small warning : this uses naming customized file
fils-g : left child
fils-d : right child:
arbre-vide? : empty tree
feuille? : leaf?
racine : root
|#
;ex2

(define (somme_noeuds a)
  (if (arbre-vide? a)
      0
      (+ (racine a) (somme_noeuds (fils-g a))
         (somme_noeuds (fils-d a)))))

(somme_noeuds a1)

(define (appartient a x)
  (if (arbre-vide? a)
      #f
      (or (equal? (racine a) x)
              (appartient (fils-g a) x)
              (appartient (fils-d a) x))))

(appartient a1 2)

#|Small tip when talking about hauteur (or height) in a tree, often we use max
to avoid further complicated complications|#
(define (hauteur a)
  (if (arbre-vide? a)
      0
      (+ 1 (max (hauteur (fils-g a))
                (hauteur (fils-d a))))))

(hauteur a1)

(define (list_feuilles a)
  (cond [(arbre-vide? a) '()]
        [(feuille? a) (list(racine a))]
        [(append
          (list_feuilles (fils-g a))
          (list_feuilles (fils-d a))) ;to erase further ()
         ]))

(list_feuilles a1)


(define (arbre-pair a)
  (cond [(arbre-vide? a) a]
        [(= (modulo (racine a) 2) 0) (arbre (racine a)
                                                    (arbre-pair (fils-g a))
                                                    (arbre-pair (fils-d a)))]
        [else (arbre 0 (arbre-pair (fils-g a))
                               (arbre-pair (fils-d a)))]))
(arbre-pair a2)

#|this is an exercice that we have to take in count the case where racine is the onl
 possible element : which is a leaf
and where we need to be assured that each recursive call that we call, has to have
an element in. So we ask whether or not the tree is empty|#
      
(define (min-arbre a)
  (cond [(feuille? a) (racine a)]
        [(arbre-vide? (fils-g a)) (min (racine a) (min-arbre (fils-g a)))]
        [(arbre-vide? (fils-d a)) (min (racine a) (min-arbre (fils-g a)))]
        [else (min (racine a) (min-arbre (fils-g a)) (min-arbre (fils-d a)))]
        ))

(min-arbre a1)

;TP5 and TP5-b

(define (prod-odd x)
  (if (empty? x)
      1 ;to avoid crash, base case for multiplication is always 1
      (if (odd? (car x))
          (* (car x) (prod-odd (cdr x)))
          (prod-odd (cdr x)))))

#|to change and alternate the numbers, we * -1 to change positif to negatif
 and base on the exemple, we notice that the negative numbers are all even so
we just need to add a condition in|#
(define (somme-alt x)
  (if (= x 1)
      1
      (if (even? x)
          (+ (* -1 x) (somme-alt (- x 1)))
          (+ x (somme-alt (- x 1))))))
(somme-alt 9)

#|here fun? is a condition such as : even? odd? or anything, we can just add in later on
whenthe functin is called. And we want to return a list so we form a base case
to be a list|#
(define (applique_predicat L fun?)
  (if (empty? L)
      (list #f)
      (if (fun? (car L))
          (cons #t (applique_predicat (cdr L) fun?))
          (cons #f (applique_predicat (cdr L) fun?))
          )))
(applique_predicat '(1 2 3 4 5 6) even?)

#|for this function there's 3 case that we need to pay attention
-where the 1st number is smaller than the second
-where the 1st number is greater than the second
-where it's in the middle|#
(define (minimaxi x)
  (if (empty? (cdr x))
      (list (car x) (car x))
      (let ((m (minimaxi (cdr x))))
        (if (< (car x) (car m))
            (list (car x) (cadr m))
            (if (> (car x) (cadr m))
                (list (car m) (car x))
                m)
            ))))
(minimaxi '(1 3 7 0 5 2))

#|so we have a and b, we need to find numbers whos greater than a and smaller than b
: or in another words, between a and b with a not included|#

(define (list-sub x a b)
  (if (empty? x)
      '()
      (if (and (> (car x) a) (<= (car x) b))
          (cons (car x) (list-sub (cdr x) a b))
          (list-sub (cdr x) a b))))

(list-sub '(1 2 3 4 5 6 7) 2 5)

#|of course there are other ways to do this such as, I advance one by one until arriving to a
and keep on adding until i'm out of zone (b). To do this I add another add-on function : aux
|#

(define (list-sub x a b)
  (define (aux L i) ;index i
    (cond ((empty? L) '()) ;if empty then, return empty list
          ((>= i b) '()) ;same if index is out of range (b)
          ((i < a)
           (aux (cdr L) (+ i 1))) 
          (
           (cons (car L)
                 (aux (cdr L) (+ i 1))))))
    (aux x 0)) ;setting up for index to be start at 0

#|It's going to be very messy and hard to write it the usual way I did so i change
 to making choices at the condition rather than after asking the condition.
So here if it's greater than root tree, we can choose to +1 or 0 depending on our
result|#

(define (nb_noeud_sup a x)
  (if (arbre-vide? a)
      0
      (+ (if (>= (racine a) x)
          1
          0)
          (nb_noeud_sup (fils-g a) x)
          (nb_noeud_sup (fils-d a) x))))

(nb_noeud_sup a1 2)

(define (som-mult3 x)
  (if (empty? x)
      0
      (if (= (modulo (car x) 3) 0)
          (+ (car x) (som-mult3 (cdr x)))
          (som-mult3 (cdr x))
          )))

 (som-mult3 '(1 3 6 2 4 3 9))


(define (list-not-leaf a)
  (if (arbre-vide? a)
      '()
      (if (feuille? a)
          (list '() )
          (cons
           (racine a) ;add racine a when its not a leaf
           (append
            (list-not-leaf (fils-g a)) (list-not-leaf (fils-d a))) ;since its a (lowkey list) we use append
          ))))
(list-not-leaf a1)

#|Same as list, but since we have to return a list then we are gong to create a
 different tree for each start|#
(define (apply_pred a fun?)
  (if (arbre-vide? a)
      '()
      (if (fun? (racine a))
          (arbre
           #t
           (apply_pred (fils-g a) fun?)
           (apply_pred (fils-d a) fun? )
           )
          (arbre
           (#f
            (apply_pred (fils-g a) fun?)
            (apply_pred (fils-d a) fun?)
            ))
          )))

#|normally it would start by left child and then right child, root would stay the same
whether the case so we just need to invert the left and right|#
 (define (miroir a)
  (if (arbre-vide? a)
      (arbre-vide)
      (arbre
       (racine a)
       (miroir (fils-d a))
       (miroir (fils-g a))
       )))

