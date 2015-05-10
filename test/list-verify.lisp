;;;; list-verify.lisp

(defpackage #:cl-99-test.list.verify
  (:use #:cl
        #:cl-99.list
        #:cl-99-test.utility))
(in-package #:cl-99-test.list.verify)

(cl-annot.syntax:enable-annot-syntax)

;;; define verifier functions for cl-99 test cases

@export
(defun verify-duplicate (in out)
  "verify if the <repli> is the replica of two times of <orig> list"
  (verify-replicate `(,(first in) 2) out))

@export
(defun verify-replicate (in out)
  "verify if the <repli> is the replica of <cnt> times of <orig> list"
  (let ((orig (first in))
        (repli out)
        (cnt (second in)))
    (print-debug "verify ~A x ~A => ~A~%" orig cnt repli)
    (let* ((orig-run-length (run-length orig))
           (repli-orig-run-length (mapcar #'(lambda (pr) `(,(* cnt (first pr)) ,(second pr)))
                                          orig-run-length))
           (repli-run-length (run-length repli)))
      (print-debug "compare ~A ~A => ~A~%"
                   repli-orig-run-length
                   repli-run-length
                   (equal repli-orig-run-length repli-run-length))
      (equal repli-orig-run-length repli-run-length))))

@export
(defun verify-drop (in out)
  "verify if the <out> matches drop test cases"
  (cond
    ((null (first in)) (null out))
    ((< (length (first in)) (second in)) (equal (first in) out))
    (t (let* ((lst (first in))
              (len (length lst))
              (s (second in)))
         (flet ((get-index (x) (- x (floor (/ x s)))))
           (and (= (get-index len) (length out))
                (loop for elem in lst
                  for i from 1
                  always (or (= 0 (mod i s))
                             (equal (nth (1- (get-index i)) out) elem)))))))))

@export
(defun verify-remove-at (in out)
  "verify if the <out> matches remove-at test cases"
  (cond
    ((null (first in)) (null out))
    ((<= (length (first in)) (second in)) (equal (first in) out))
    (t (and (= (length (first in)) (1+ (length out)))
            (loop for elem in out
                  for i from 0
                  always (equal (nth (if (< i (second in)) i (1+ i))
                                     (first in))
                                elem))))))

@export
(defun verify-split (in out)
  "verify if the <out> is the pair of subsequences split from <in>"
  (let ((lst (first in))
        (front-len (second in)))
    (and (equal (subseq lst 0 front-len) (first out))
         (equal (subseq lst front-len) (second out)))))

@export
(defun verify-slice (in out)
  "verify if the <out> is the slice extracted from the <in>"
  (if (not (first in))
    (null out)
    (equal (subseq (first in) (1- (second in)) (third in)) out)))

@export
(defun verify-rotate (in out)
  "verify if the <out> is the rotated result of <in>"
  (print-before-return (let* ((step (second in))
         (lst (first in))
         (len (length lst)))
    (and (equal len (length out))
         (or (= 0 len)
             (loop for elem in out
                   for i from 0
                   do (if *print-details* (format t "@~A ~A ~A ~A~%" i (mod (+ i step) len) (nth (mod (+ i step) len) lst) elem))
                   always (equal (nth (mod (+ i step) len) lst)
                                 elem)))))))
