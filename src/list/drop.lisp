(in-package #:cl-99)

;; P16 (**) Drop every N'th element from a list.

(defun drop-loop (lst n)
  (loop for elem in lst
        for i from 1
        unless (= 0 (mod i n))
        collect elem))

;; P20 (*) Remove the K'th element from a list, counting from 0.

(defun remove-at-rec (lst n)
  "remove-ats the nth element from the list"
  (cond
    ((not lst) nil)
    ((= 0 n) (rest lst))
    (t (cons (first lst) (remove-at-rec (rest lst) (1- n))))))

(defun remove-at-ite (lst n)
  (labels ((inner-remove-at (lst n res)
             (if (not lst)
               res
               (progn
                 (if (not (= 0 n)) (push (first lst) res))
                 (inner-remove-at (rest lst) (1- n) res)))))
    (nreverse (inner-remove-at lst n '()))))

(defun remove-at-loop (lst n)
  (loop for elem in lst
        for i from 0
        unless (= n i)
        collect elem))
