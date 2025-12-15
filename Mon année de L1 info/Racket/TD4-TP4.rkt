#lang racket

;TD4 and TP4 (maybe)

(define (mininum L)
  (if (empty? L)
      '()
      (car (sort L <)))) ;sort by smallest to biggest and return the first
(mininum '(3 2 5 6))

;second method if we can't use sort

(define (mininum2 L)
  (if (empty? (cdr L))
      (car L)
      (if (< (car L) (mininum2 (cdr L))) ;direct comparision, no need to further
          ;complicate the process by separating it into car vs cadr 
          (car L)
          (mininum2 (cdr L)))))

(define (appartient L x)
  (if (empty? L)
      #f
      (if (equal? (car L) x)
          #t
          (appartient (cdr L) x)
          )))
(appartient '(1 2 3 4 5) 2)

(define (repete L)
  (if (empty? L)
      '()
      (cons (car L) (cons (car L) (repete (cdr L))))
      ))

;cons here because append only works with 2 lists and if we make 2 lists, it wil add further ()
;and its completely unnecessary

(define (evenodd L)
  (if (empty? L)
      (list 0 0) ;as the base has to be inline with what the result expected to be return
      ;we need to etablish the form : in this case, we want to return a list with 2 elements (how many even numbers and odd numbers are)
      (let ((m (evenodd (cdr L))))
        ;we call m the recursive call on the rest of the list to make the
        ;functin shorter but seeing how many comments I've added so far, no its not shorter
        (if (even? (car L)) ;we check if its even
            (list ;make a list here because the res is expected to be a list
             (+ 1 (car m)) 
             (cadr m)) ;car and cadr that we address here it's the list that we have etablished
            (list
             (car m)
             (+ 1 (cadr m))
             )))))

;same principle here, only the condition had changed 
(define (separe L)
  (if (empty? L)
      (list '() '())
      (let ((m (separe (cdr L))))
        (if (number? (car L))
          (list
           (cons (car L) (car m))
           (cadr m))
          (list
           (car m)
           (cons (car L) (cadr m))
           )
          ))))

(separe '(1 #t (2 3) "a" 5 0))

#|As you can see in the latest function that we created, separe : there is a sub list
 that contains numbers but we did not address it : because it's a list and not numbers
 so in this section here, we will be doing function that address sublist
|#

(define (reverse-prof L)
  (if (empty? L)
      '()
      (if (list? (car L)) ;we ask if it's a list
          (append (reverse-prof (cdr L))
                  (list (reverse-prof (car L)))) ;both are lists so we need to use append
          (append (reverse-prof (cdr L))
                  (list (car L))))))
;in fact we need to add list to car L (because its not yet a list) but also reverse-prof
;because append will erase our needed () so to conserve () we add list to annule them

(reverse-prof '(1 2 (3 4 5)))

;same principle here, but we count the numbers in list and sublist
(define (nb_sousliste L)
  (if (empty? L)
      0
      (if (list? (car L))
          (+ 1 (nb_sousliste (car L))
             (nb_sousliste (cdr L)))
          (+ 1 (nb_sousliste (cdr L)))
          )))

(define (count-occurrences x L)
  (cond
    [(null? L) 0]
    [(not (pair? L)) 0] ; if it's a pair list then we can't do car/cdr
    ;this is to avoid crashing with racket
    [(list? (car L))
     (+ (count-occurrences x (car L))
        (count-occurrences x (cdr L)))]
    [else
     (+ (if (equal? x (car L)) 1 0)
        (count-occurrences x (cdr L)))]))
         
(count-occurrences '(1 2 (3 4 6 5 6 6)) 6)

(define (add2_prof L)
  (if (empty? L)
      '()
      (if (list? (car L))
          (cons (add2_prof (car L))
             (add2_prof (cdr L)))
          (cons (+ 2 (car L))
                (add2_prof (cdr L))))))

(add2_prof '(1 2 3 (3 4 6 5 6 6)))

(define (profondeur L)
  (if (empty? L)
      0
      (if (list? (car L))
      (+ 1 (max (profondeur (car L))
                (profondeur (cdr L))))
      (profondeur (cdr L))
      )))

(define (enleve x L)
  (if (empty? L)
      '()
      (if (equal? x (car L))
          (enleve (cdr L))
          (cons (car L) (enleve (cdr L)))
          )))

(define (tri-min L)
  (if (empty? L)
      '()
      (let ([m (mininum L)])              ; we calculate the mininum once
        (cons m
              (tri-min (enleve m L))))))

;we need to look for the mininum of the list
;we then erase the same occurrence ofsaid number/elements in the said list
;and we filter the rest

;ex4
(define (insere2 x L)
  (cond
    [(empty? L) (list x)]         ; if list is empty → just x
    [(<= x (car L))               ; if x is smaller
     (cons x L)]
    [else                         ; if not we continue compare x with the rest
     (cons (car L)
           (insere2 x (cdr L)))]))

(insere2 0 '(1 2 3 4))

(define (tri-insertion L)
  (if (empty? L)
      '()                         ; base case where list is already prep
      (insere2 (car L) ;insere x
              (tri-insertion (cdr L)))))

;ex5

;this is an exercice with map, foldr, andmap. Further explainations are recommeneded
;to consult the offical docs of Racket

#|small note on how to write proper syntax with map, andmap, ormap|#

;for map / andmap / ormap
;no need for if : just write the condition or the calculs
;and later on add the map func in

;2 defines : one is the func we'll call it later on and the
;second one is the one to define with n (element of said list)

(define (f1 L)
  (define (puiss4 n)
    (* n n n n))      
  (map puiss4 L))     

(f1 '(1 2 3 4))

(define (f2 L)
  (define (positive n)
    (> n 0))              
  (andmap positive L))    

(f2 '(-1 3 4 0))

(define (f3 x L)
  (define (appartient n)
    (equal? x n))
 (ormap appartient L))    

(f3 1 '(1 2 3 4))

;match : a function to research certain patterns 
(define (f4 L)
  (match L
    [(list (? positive? n)) 0]                 ; if 1 positif
    [(list (? negative? a) (? negative? b)) 1] ; if 2 negatif
    [_ 2]))                                    ; if not

;TP4

(define (premiers L n)
  (if (= n 1)
      (list (car L))
      (append (list (car L) (premiers (cdr L) (- n 1)))
      )))
(premiers '(1 2 5 6 8) 3)


(define (opp-prof L)
  (if (empty? L)
      '()
      (if (list? (car L))
          (cons (opp-prof (car L))
                (opp-prof (cdr L)))
          (if (number? (car L))
          (cons (- (car L))
                (opp-prof (cdr L)))
          (cons (car L)
                (opp-prof (cdr L)))))))
(opp-prof '(1 2 3 4 5))

(define (posneg L)
  (if (empty? L)
      (list '() '())
      (let ((m (posneg (cdr L))))
        (if (> (car L) 0)
            (list
             (cons (car L) (car m))
             (cadr m))
            (list
             (car m)
             (cons (car L) (cadr m)))
            ))))

            