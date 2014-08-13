;; P02 (*) Find the last but one box of a list.

(in-package #:cl-99)

(defun my-but-last (lst)
  "get the last but one element of a list"
  (let ((rst (rest lst))) ; (rest nil) => nil
    (cond
      ((not rst) nil) ; cover nil and list with single item
      ((not (rest rst)) (first lst)) ; two items
      (t (my-but-last rst)))))