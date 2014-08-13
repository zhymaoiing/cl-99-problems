;; P03 (*) Find the K'th element of a list.

(in-package #:cl-99)

(defun my-nth-rec (lst n)
  "get the nth (index from 0) element of a list recursively"
  (labels ((inner-nth-rec (lst n)
             (cond
               ((not lst) nil)
               ((= 0 n) (first lst))
               (t (inner-nth-rec (rest lst) (- n 1))))))
    (inner-nth-rec lst n)))

(defun my-nth-loop (lst n)
  "get the nth (index from 0) element of a list using loop"
  (loop for elem in lst
        for i from 0 to n
        when (= n i) return elem)) ;return nil if the condition is never met