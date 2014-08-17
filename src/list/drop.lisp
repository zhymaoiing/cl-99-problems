;; P16 (**) Drop every N'th element from a list.

(in-package #:cl-99)

(defun drop-rec (lst n)
  "drops the nth element from the list"
  (cond
    ((not lst) nil)
    ((= 0 n) (rest lst))
    (t (cons (first lst) (drop-rec (rest lst) (1- n))))))

(defun drop-ite (lst n)
  (labels ((inner-drop (lst n res)
             (if (not lst)
               res
               (progn
                 (if (not (= 0 n)) (push (first lst) res))
                 (inner-drop (rest lst) (1- n) res)))))
    (nreverse (inner-drop lst n '()))))

(defun drop-loop (lst n)
  (loop for elem in lst
        for i from 0
        unless (= n i)
        collect elem))
