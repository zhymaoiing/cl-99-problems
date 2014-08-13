;; P01 (*) Find the last box of a list.

(in-package #:cl-99)

(defun my-last (lst)
  "get the last element of a list"
  (cond
    ((not lst) nil)
    ((not (rest lst)) (first lst))
    (t (my-last (rest lst)))))