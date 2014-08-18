;; Verifier functions

(in-package #:cl-99-test)

(defun verify-duplicate (in out)
  "verify if the <repli> is the replica of two times of <orig> list"
  (verify-replicate `(,(first in) 2) out))

(defun verify-replicate (in out)
  "verify if the <repli> is the replica of <cnt> times of <orig> list"
  (let ((orig (first in))
        (repli out)
        (cnt (second in)))
    (if *print-details* (format t "verify ~A x ~A => ~A~%" orig cnt repli))
    (print-before-return
      (let* ((orig-run-length (run-length orig))
             (repli-orig-run-length (mapcar #'(lambda (pr) `(,(* cnt (first pr)) ,(second pr)))
                                            orig-run-length))
             (repli-run-length (run-length repli)))
        (format t "compare ~A ~A => ~A~%" repli-orig-run-length repli-run-length (equal repli-orig-run-length repli-run-length))
        (equal repli-orig-run-length repli-run-length)))))

(defun verify-drop (in out)
  "verify if the <out> matches drop test cases"
  (cond
    ((null (first in)) (null out))
    ((<= (length (first in)) (second in)) (equal (first in) out))
    (t (and (= (length (first in)) (1+ (length out)))
            (loop for elem in out
                  for i from 0
                  always (equal (nth (if (< i (second in)) i (1+ i))
                                     (first in))
                                elem))))))

(defun verify-split (in out)
  "verify if the <out> is the pair of subsequences split from <in>"
  (let ((lst (first in))
        (front-len (second in)))
    (and (equal (subseq lst 0 front-len) (first out))
         (equal (subseq lst front-len) (second out)))))

(defun verify-slice (in out)
  "verify if hte <out> is the slice extracted from the <in>"
  (format t "=> slice ~A ~A~%" in out)
  (if (not (first in))
    (null out)
    (equal (subseq (first in) (1- (second in)) (third in)) out)))

