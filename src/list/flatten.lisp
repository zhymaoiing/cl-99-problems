;; P07 (**) Flatten a nested list structure.

(in-package #:cl-99)

(defun flatten (lst)
  "flatten the given list structure"
  (if (listp lst)
    (reduce #'append (mapcar #'flatten lst))
    (list lst)))
