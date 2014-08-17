;; P10 (*) Run-length encoding of a list.
;; E.g., (a a a a b c c a a d e e e e) => ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e))

(in-package #:cl-99)

(defun run-length (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length"
  (operate-on-consecutive-duplicates
    lst
    (lambda (lst) `((1 ,(first lst))))
    (lambda (r x) 
      (if (equal (second (first r)) x)
        (incf (first (first r)))
        (push `(1 ,x) r))
      r)))

(defun run-length-direct (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length relying on result from my-pack"
  (loop for l in (my-pack lst)
        collect `(,(length l) ,(first l))))
