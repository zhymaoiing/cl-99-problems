;; P17 (*) Split a list into two parts; the length of the first part is given.

(in-package #:cl-99-test)

(define-cl-test-named
  split
  (generate-list-test-cases
    nil
    #'(lambda (lst) `(,lst ,(random (1+ (length lst)))))
    'verify-split))
