;;;; define tests on simple list operations

(in-package #:cl-99-test)

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
