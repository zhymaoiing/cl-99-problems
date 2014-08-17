(in-package #:cl-99)

;; P14 (*) Duplicate the elements of a list.
;; E.g.,  (dupli '(a b c c d)) => (a a b b c c c c d d)

(defun my-dupli (lst)
  "duplicate the elements of a list"
  (loop for pr in lst
        append (duplicate 2 pr)))


;; P15 (**) Replicate the elements of a list a given number of times.
;; E.g.,  (repli '(a b c c d) 3) => (a a a bb b c c c c c c d d d)

(defun my-repli (lst cnt)
  (reduce #'append (mapcar #'(lambda (x) (duplicate cnt x)) lst)))
