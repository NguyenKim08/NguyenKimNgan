#lang racket
(require racket/include)
(include "primitives.rkt")

(define a1 '(4 (2 () ()) (8 (0 () ()) (6 () ()))))
(define a2 '(6 (4 (1 () ()) (5 () ())) (9 () ())))
(define a3 '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))


(define (ajoute1 a)
  (if (arbre-vide? a)
      a
      (arbre
       (+ 1 (racine a))
         (ajoute1 (fils-g a))
         (ajoute1 (fils-d a))
         )))

      
(ajoute1 a1)

#|postfixe : left child, right child, root|#

(define (postfixe a)
  (if (arbre-vide? a)
      '()
       (append
        (postfixe (fils-g a))
        (postfixe (fils-d a))
        (list (racine a)))))

(postfixe a1)

#|so like one of the past function that we had, this is a case where
 we need to check if the rest of the leaves are empty.
Then we can make a sum of all the leaves. THe result is expected to be a tree so
we need to return as such|#

(define (somme-fils a)
  (if (arbre-vide? a)
      (arbre-vide)
      (let ((g (somme-fils (fils-g a)))
            (d (somme-fils (fils-d a))))
        (arbre (+ (racine a) ;end of case where we need to add the root
                  (if (arbre-vide? g) 0 (racine g))
                  (if (arbre-vide? d) 0 (racine d)))
                       g;recursive call for left and right child
                       d))))

#|could be the same as somme-fils, however the exercice asks me to add another
add-ons, which is v where v holds the sum that to be added in each call|#

(define (somme-pere a)
  (define (somme-pere-aux a n) ;add ons function
    (if (arbre-vide? a)
        a
        (let ((v (+ (racine a) n))) ;this is the highest parent of each leaf
          (arbre v
                 (somme-pere-aux (fils-g a) v)
                 (somme-pere-aux (fils-d a) v)))))
  (somme-pere-aux a 0))

(somme-pere a1)

#|This is where ABR is applied, abr is another type of tree where whatever values is smaller than the
 root is on the left and whatever values greater than the root is on the right|#

#|we know that we are searching for the smallest in the tree
 so it's on the left, we check if its empty -> return root if not
we can just call it again until we reach the smallest : in this case, the furtherest leaf|#
(define (mininum-abr a)
  (if (arbre-vide? (fils-g a))
      (racine a)
      (mininum-abr (fils-g a)))
      )
(mininum-abr a2)

#|we set base case when the tree is empty, we just add x as the root
 then depends on whether or not x is greater than the root we then place it left or right
and set up a new tree|#

(define (insere-abr a x)
  (if (arbre-vide? a)
      (arbre
       (racine x)
       (arbre-vide)
       (arbre-vide)
       )
      (if (< (racine a) x)
          (arbre (racine a) (insere-abr x (fils-g)) (fils-d a))
          (arbre (racine a) (fils-g a) (insere-abr x (fils-d a))))
      ))
          
(insere-abr a2 8)

#|to check if a tree is an abr tree, we need to use its definition : which is
 greater than root lies on the right and smaller than root lies on the left.
Here, we check if the left or right is empty, and we use max/min already etablished before
we search for the max/min of said branch and compare it to the root. If yes then the tree is abr tree
Keep in mind, there are two big possibilities here :
-Either the left is empty
-The right is empty
or nothing is empty|#

(define (maxinum-abr a)
  (if (arbre-vide? (fils-d a))
      (racine a)
      (mininum-abr (fils-d a))))

(define (est-abr? a)
  (cond ((arbre-vide? a) #f)
        ((feuille? a) #t)
        ((arbre-vide? (fils-g a)) (and (< (racine a) (mininum-abr (fils-d a))) (est-abr? (fils-d a))))
        ((arbre-vide? (fils-d a)) (and (> (racine a) (maxinum-abr (fils-g a))) (est-abr? (fils-g a))))
        (else (and (est-abr? (fils-g a))
                   (est-abr? (fils-d a))
                   (< (racine a) (minimum-abr (fils-d a)))
                   (> (racine a) (maximum-abr (fils-g a)))))))
#|as for this right here : same definition but : 3 cases.
 -Either the tree us empty, we send back the tree
-if not we delete the x in the tree
-if root is a leaf, then we senc back empty tree, or if either branch is empty then
we can send back the other non empty one.
-and since its said in the exercice that we can replace when its neessary by the mininum of the left branch, we can just reuse the function that we have built
|#
(define (supprime a x)
  (cond ((arbre-vide? a) a)
        ((< x (racine a)) (arbre (racine a) (supprime (fils-g a) x) (fils-d a)))
        ((> x (racine a)) (arbre (racine a) (fils-g a) (supprime (fils-d a) x)))
        (else
         (if (feuille? a)
             (arbre-vide)
             (if (arbre-vide? (fils-g a))
                 (fils-d a)
                 (if (arbre-vide? (fils-d a))
                     (fils-g a)
                     (arbre (maximum-abr (fils-g a))
                                    (supprime (fils-g a) (maximum-abr (fils-g a)))
                                    (fils-d a))))))))


#|by now, you must notice the same way i did that mostly function that we created/did
on tree is by manipulating the base case. So it's the same here where, we need to return
all te children that are in between x and y. We set up the limit on where we go and when do we start.
|#
(define (filtre a x y)
  (if (arbre-vide? a)
      (arbre-vide)
      (if (< (racine a) x) ;if x smaller than x, stop
         (arbre-vide)
          (if (> (racine a) y) ;if y greater than y, stop
              (arbre-vide)
              (arbre (racine a) ;send back the between
                     (filtre (fils-g a) x y)
                     (filtre (fils-d a) x y))))))
#|these last exercices requires not a list nor a tree, its needs direction whereas g : left, d : right. We need to find the path that leads out
 of the tree|#
(define (chemin-sort? a c) ;c for path
    (cond ((arbre-vide? a) #t) ;if tree is empty
          ((null? c) #f) ;if path is empty
          ((equal? 'g (car c)) (chemin-sort? (fils-g a) (cdr c))) ;if the first
          ;direction is g, then we continuefor the rest until the end
          (else (chemin-sort? (fils-d a) (cdr c))))) ;if we dont start with g, then we go ti
;the right : d and we go until the end of the directions given

#|same thing here |#

(define (somme-chemin a c)
  (if (arbre-vide? a)
      0
      (if (empty? c) ;if directions given are empty
          (racine a)
          (+ (racine a) ;we need to ad the root any case
             (if (equal? (car c) 'g)
                 (somme-chemin (fils-g a) (cdr c)) ;go left if the 1st direction is g
                 (somme-chemin (fils-d a) (cdr c))))))) ;go right