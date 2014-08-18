;; P17 (*) Split a list into two parts; the length of the first part is given.

(in-package #:cl-99)

(defun split (lst n)
  (loop for elem in lst
        for i from 0
        with front and end
        do (if (< i n) (push elem front) (push elem end))
        finally (return `(,(nreverse front) ,(nreverse end)))))
