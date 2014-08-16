;; P11 (*) Modified run-length encoding.

(in-package #:cl-99)

(defun length-consecutive-duplicates-modified (lst)
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

(defun length-consecutive-duplicates-modified-pre (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length relying on result from length-consecutive-duplicates"
  (loop for l in (length-consecutive-duplicates lst)
        collect (if (= 1 (first l)) (second l) l)))
