;; P06 (*) Find out whether a list is a palindrome.

(in-package #:cl-99)

(defun palindrome-p (lst)
  "test if the given list is palindrome"
  (equal lst (reverse lst)))

