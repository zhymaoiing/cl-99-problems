;;;; define tests on simple list operations

(in-package #:cl-99-test)

(defvar *list-test-cases*
  '((1 2 3 4 5)
    (1 2)
    (1)
    ()))

(defun generate-list-test-cases (result-func)
  (loop for l in *list-test-cases*
        collect `((,l) ,(funcall result-func l))))

;; P01 (*) Find the last box of a list.

(define-cl-test #'my-last my-last (generate-list-test-cases #'last))

;; P02 (*) Find the last but one box of a list.

(define-cl-test #'my-but-last my-but-last (generate-list-test-cases #'(lambda (x) (second (reverse x)))))

;; P03 (*) Find the K'th element of a list.

(define-cl-tests
  '(#'my-nth-rec #'my-nth-loop)
  `((my-nth ,(reduce #'append
                     (mapcar #'(lambda (lst)
                                 (cons
                                   `((,lst -1) nil)
                                   (loop for i from 0 to (+ (length lst) 2)
                                         collect `((,lst ,i) ,(nth i lst)))))
                             *list-test-cases*)))))

;; P04 (*) Find the number of elements of a list.

(define-cl-tests
  '(#'my-length-ite #'my-length-rec #'my-length-loop)
  `((my-length ,(generate-list-test-cases #'length))))

;; P05 (*) Reverse a list.

(define-cl-tests
  '(#'my-reverse-ite #'my-reverse-loop)
  `((my-reverse ,(generate-list-test-cases #'reverse))))
