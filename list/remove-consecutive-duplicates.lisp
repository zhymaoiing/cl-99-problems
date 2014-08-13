;; P08 (**) Eliminate consecutive duplicates of list elements.

(in-package #:cl-99)

(defun remove-consecutive-duplicates (lst)
  "remove consecutive duplicates in the given list"
  (if (null lst) 
    nil
    (nreverse (reduce #'(lambda (r x)
                          (if (equal (first r) x)
                            r
                            (push x r)))
                      (rest lst) ;avoid case like (list nil)
                      :initial-value (list (first lst))))))