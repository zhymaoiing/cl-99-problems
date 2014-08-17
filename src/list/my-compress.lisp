;; P08 (**) Eliminate consecutive duplicates of list elements.

(in-package #:cl-99)

(defun my-compress (lst)
  "remove consecutive duplicates in the given list"
  (operate-on-consecutive-duplicates
    lst
    (lambda (lst) (list (first lst)))
    (lambda (r x) (if (equal (first r) x)
                    r
                    (push x r)))))
