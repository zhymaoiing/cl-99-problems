;;;; cl-99.lisp

(defpackage #:cl-99
  (:use #:cl)
  ;; symbols for list operations
  ;; TODO: merge multiple symbols about the same problem to a single one which might represents a list of all previous symbols
  (:export :my-last
           :my-but-last
           :my-nth-rec
           :my-nth-loop
           :my-length-rec
           :my-length-ite
           :my-length-loop
           :my-reverse-ite
           :my-reverse-loop
           :palindrome-p
           :flatten
           :remove-consecutive-duplicates))

