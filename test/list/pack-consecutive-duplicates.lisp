;; P09 (**) Pack consecutive duplicates of list elements into sublists.

(in-package #:cl-99-test)

(define-cl-test
  'pack
  #'remove-consecutive-duplicates
  '(((() nil))
    ((nil) (nil))
    ((1) (1))
    ((1 1) (1))
    ((1 1 1 1 1) (1))
    ((1 1 nil 1 1) (1 nil 1))
    ((nil 1 2 3 3) (nil 1 2 3))
    ((1 2 3 3 nil) (1 2 3 nil))
    ((1 1 1 1 1 2) (1 2))
    (("123" "123") ("123"))   
    (("123" 1 1 "123") ("123" 1 "123"))
    ((a a a a b c c a a d e e e e) (a b c a d e))   
    ((a a a nil a b c c a a d e e e e) (a nil a b c a d e))))
