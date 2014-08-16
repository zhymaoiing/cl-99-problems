;; P10 (*) Run-length encoding of a list.

(in-package #:cl-99)

(defun length-consecutive-duplicates (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length"
  (operate-on-consecutive-duplicates
    lst
    (lambda (lst) `((1 ,(first lst))))
    (lambda (r x) 
      (if (equal (second (first r)) x)
        (incf (first (first r)))
        (push `(1 ,x) r))
      r)))

(defun length-consecutive-duplicates-pre (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length relying on result from pack-consecutive-duplicates"
  (loop for l in (pack-consecutive-duplicates lst)
        collect `(,(length l) ,(first l))))
