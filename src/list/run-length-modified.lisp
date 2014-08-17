;; P11 (*) Modified run-length encoding.
;; P13 (**) Run-length encoding of a list (direct solution).
;; E.g., (a a a a b c c a a d e e e e) => ((4 a) b (2 c) (2 a) d (4 e))

(in-package #:cl-99)

(defun run-length* (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length"
  (operate-on-consecutive-duplicates
    lst
    (lambda (lst) `(,(first lst)))
    (lambda (r x) 
      (let* ((a (first r))
             (b (if (listp a) (second a) a))
             (c (if (listp a) (first a) 1)))
        (if (equal b x)
          (setf (first r) `(,(1+ c) ,x))
          (push x r))
        )
      r)))

(defun run-length*-direct (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length relying on result from run-length"
  (loop for l in (run-length lst)
        collect (if (= 1 (first l)) (second l) l)))
