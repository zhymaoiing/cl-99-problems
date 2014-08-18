;; P18 (**) Extract a slice from a list.
;; Given two indices, I and K, the slice is the list containing the elements between the I'th and K'th element of the original list (both limits included). Start counting the elements with 1.

(in-package #:cl-99)

(defun skip (lst n)
  (loop for sub on lst
        for i from 0
        while (< i n)
        finally (return sub)))

(defun slice (lst start end)
  (if (> start end)
    (error "start of slice cannot be larger than end, we get ~A ~A" start end))
  (first (split (skip lst (1- start)) (1+ (- end start)))))
