;; P16 (**) Drop every N'th element from a list.

(in-package #:cl-99-test)

(define-cl-tests
  '(#'drop-rec #'drop-ite #'drop-loop)
  `((drop
      ,(generate-list-test-cases
         nil
         ;; generate a index which could be out of range
         #'(lambda (lst) `(,lst ,(random (+ 10 (length lst)))))
         'verify-drop))))
