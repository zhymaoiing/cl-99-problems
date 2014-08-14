;; P09 (**) Pack consecutive duplicates of list elements into sublists.

(in-package #:cl-99)

(defun pack-consecutive-duplicates (lst)
  "pack consecutive duplicates in the given list into sublists"
  (operate-on-consecutive-duplicates
    lst
    (lambda (lst) (list (list (first lst))))
    (lambda (r x) 
      (if (equal (first (first r)) x)
                    (push x (first r))
                    (push (list x) r))
      r)))
