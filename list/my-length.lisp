;; P04 (*) Find the number of elements of a list.

(in-package #:cl-99)

(defun my-length-rec (lst)
  "get the length of a list recursively"
  (if (null lst)
    0
    (1+ (my-length-rec (rest lst)))))

(defun my-length-ite (lst)
  "get the length of a list iterately"
  (labels ((inner-length (lst n)
             (if (null lst)
               n
               (inner-length (rest lst) (1+ n)))))
    (inner-length lst 0)))

(defun my-length-loop (lst)
  "get the length of a list using loop"
  (loop for elem in lst count elem))