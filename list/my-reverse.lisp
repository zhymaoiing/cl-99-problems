;; P05 (*) Reverse a list.

(in-package #:cl-99)

(defun my-reverse-ite (lst)
  "reverse a list iterately"
  (labels ((inner-reverse (lst res)
             (if (null lst)
               res
               (inner-reverse (rest lst) (cons (first lst) res)))))
    (inner-reverse lst nil)))

(defun my-reverse-loop (lst)
  "reverse a list using loop"
  (loop for elem in lst with res
        do (push elem res)
        finally (return res)))
