;;;; list-cases.lisp

(defpackage #:cl-99-test.list.cases
  (:use #:cl
        #:cl-99.utility
        #:cl-99.list
        #:cl-99-test.utility
        #:cl-99-test.list.utility
        #:cl-99-test.list.verify))
(in-package #:cl-99-test.list.cases)

(cl-annot.syntax:enable-annot-syntax)

;;; define test cases for list-related cl-99 problems

;; P01 (*) Find the last box of a list.
(define-cl-test-named my-last (generate-list-test-cases #'(lambda (x) (first (last x)))))

;; P02 (*) Find the last but one box of a list.
(define-cl-test-named my-but-last (generate-list-test-cases #'(lambda (x) (second (reverse x)))))

;; P03 (*) Find the K'th element of a list.
(define-cl-tests
  '(#'my-nth-rec #'my-nth-loop)
  `((my-nth ,(join #'(lambda (lst)
                       (cons
                         `((,lst -1) nil)
                         (loop for i from 0 to (+ (length lst) 2)
                               collect `((,lst ,i) ,(nth i lst)))))
                   *cases-of-lists-tests*))))

;; P04 (*) Find the number of elements of a list.
(define-cl-tests
  '(#'my-length-ite #'my-length-rec #'my-length-loop)
  `((my-length ,(generate-list-test-cases #'length))))

;; P05 (*) Reverse a list.
(define-cl-tests
  '(#'my-reverse-ite #'my-reverse-loop)
  `((my-reverse ,(generate-list-test-cases #'reverse))))
  
;; P06 (*) Find out whether a list is a palindrome.
(define-cl-test
  #'palindrome-p
  palindrome-p
  '(((()) t)  
    (((1)) t)
    (((1 1)) t)
    (((1 2)) nil)
    (((1 1 1 1)) t)
    (((1 2 3 4 5)) nil)
    (((1 2 3 2 1)) t)
    ((("123" 3 "123")) t)
    ((("123" 3 "123" 1)) nil)
    (((1 "123" #\a "123")) nil)
    (((1 "123" #\a "123" 1)) t)
    (((1 "1" 3 "123" 1)) nil)
    (((x a m a x)) t)
    (((3 "123" #\a)) nil)))
    
;; P07 (**) Flatten a nested list structure.
(define-cl-tests
  '#'flatten
  '((flatten-simple
      (((()) nil)
       (((1)) (1))
       (((1 2 3 4 5)) (1 2 3 4 5))
       ((("123" 3 "123")) ("123" 3 "123"))))
    (flatten-xyz-single
      ((((x y z)) (x y z))
       ((((()) x y z)) (x y z))
       ((((x) () y z)) (x y z))
       ((((x) y z ())) (x y z))
       ((((x) y (z))) (x y z))
       ((((x) (y z))) (x y z))
       (((((x y)) z)) (x y z))
       (((((x y z)))) (x y z))   
       ((((((x y z))))) (x y z))))
    (flatten-xyz
      ((((() (x y z))) (x y z))
       (((() (x y z) ())) (x y z))
       (((() (x) (y) (z) ())) (x y z))
       (((() ((x) (y) (z)) ())) (x y z))   
       (((() ((x) () () (y ()) () (() z)) ())) (x y z))   
       ((((x) (y z))) (x y z))
       ((((x y) (z))) (x y z))))
    (flatten-random-tree
      ((((7 (6 (4 () 5)) 9 (8) 11 () 13)) (7 6 4 5 9 8 11 13)) ;pre-order traversal
       (((((() 4 5) 6) 7 (8) 9 () 11 13)) (4 5 6 7 8 9 11 13)) ;in-order traveresal
       (((((() 5 4) 6) (8) () 13 11 9 7)) (5 4 6 8 13 11 9 7)) ;post-order traversal
       ))))

;; P08 (**) Eliminate consecutive duplicates of list elements.
(define-cl-test-named my-compress (generate-cd-test-cases #'first))

;; P09 (**) Pack consecutive duplicates of list elements into sublists.
(define-cl-test-named
  my-pack
  (generate-cd-test-cases
    #'(lambda (pr) (loop repeat (second pr) collect (first pr)))))

;; P10 (*) Run-length encoding of a list.
(define-cl-tests
  '(#'run-length #'run-length-direct)
  `((run-length ,(generate-cd-test-cases #'reverse))))

;; P11 (*) Modified run-length encoding.
;; P13 (**) Run-length encoding of a list (direct solution).
(define-cl-tests
  '(#'run-length* #'run-length*-direct)
  `((run-length*
     ,(generate-cd-test-cases
        #'(lambda (pr) (if (= 1 (second pr)) (first pr) (reverse pr)))))))

;; P12 (**) Decode a modified run-length encoded list.
(define-cl-test-named decode-run-length (generate-decode-cd-test-cases))

;; P14 (*) Duplicate the elements of a list.
(define-cl-test-named
  my-dupli
  (generate-list-test-cases
    nil
    nil
    'verify-duplicate))

;; P15 (**) Replicate the elements of a list a given number of times.
(define-cl-test-named
  my-repli
  (generate-list-test-cases-func-gen
    #'(lambda ()
        ;; zero times is not invalid
        (let ((repli-cnt (1+ (random *repli-limit*))))
          (values
            #'(lambda (x) `(,x ,repli-cnt))
            'verify-replicate)))))

;; P16 (**) Drop every N'th element from a list.
(define-cl-test-named
  drop-loop
  (generate-list-test-cases
    nil
    #'(lambda (lst) `(,lst ,(1+ (let ((len (length lst)))
                                  (if (= 0 len) 0 (random len))))))
    'verify-drop))

;; P17 (*) Split a list into two parts; the length of the first part is given.
(define-cl-test-named
  split
  (generate-list-test-cases
    nil
    #'(lambda (lst) `(,lst ,(random (1+ (length lst)))))
    'verify-split))

;; P18 (**) Extract a slice from a list.
(define-cl-test-named
  slice
  (generate-list-test-cases
    nil
    #'(lambda (lst)
        (let ((len (length lst)))
          (flet ((gen-index () (if (= 0 len) 0 (1+ (random len)))))
            (let ((a (gen-index))
                  (b (gen-index)))
              `(,lst ,(min a b) ,(max a b))))))
    'verify-slice))

;; P19 (**) Rotate a list N places to the left.
(define-cl-test-named
  rotate
  (generate-list-test-cases
    nil
    #'(lambda (lst)
        (let* ((len (length lst))
               (step (if (= 0 len)
                       0
                       (- (* 5 len) (random (* 10 len))))))
          `(,lst ,step)))
    'verify-rotate))

;; P20 (*) Remove the K'th element from a list.
(define-cl-tests
  '(#'remove-at-rec #'remove-at-ite #'remove-at-loop)
  `((remove-at
      ,(generate-list-test-cases
         nil
         #'(lambda (lst) `(,lst ,(random (+ 10 (length lst)))))
         'verify-remove-at))))
