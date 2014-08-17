;; P12 (**) Decode a modified run-length encoded list.

(in-package #:cl-99)

(defun decode-run-length (lst)
  "unpack consecutive duplicates in the given modified run-length encoded list"
   (loop for pr in lst
         append (if (listp pr)
                  (duplicate (first pr) (second pr))
                  (list pr))))
