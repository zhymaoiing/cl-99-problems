;;;; list.lisp

(defpackage #:cl-99.list
  (:use #:cl
        #:cl-99.list.utility)
  (:import-from #:cl-99.utility
                :duplicate))
(in-package #:cl-99.list)

(cl-annot.syntax:enable-annot-syntax)

;;; problems related to lists

;; P01 (*) Find the last box of a list.
@export
(defun my-last (lst)
  "get the last element of a list"
  (cond
    ((not lst) nil)
    ((not (rest lst)) (first lst))
    (t (my-last (rest lst)))))

;; P02 (*) Find the last but one box of a list.
@export
(defun my-but-last (lst)
  "get the last but one element of a list"
  (let ((rst (rest lst))) ; (rest nil) => nil
    (cond
      ((not rst) nil) ; cover nil and list with single item
      ((not (rest rst)) (first lst)) ; two items
      (t (my-but-last rst)))))


;; P03 (*) Find the K'th element of a list.
@export
(defun my-nth-rec (lst n)
  "get the nth (index from 0) element of a list recursively"
  (cond
    ((not lst) nil)
    ((= 0 n) (first lst))
    (t (my-nth-rec (rest lst) (- n 1)))))

@export
(defun my-nth-loop (lst n)
  "get the nth (index from 0) element of a list using loop"
  (loop for elem in lst
        for i from 0 to n
        when (= n i) return elem)) ;return nil if the condition is never met

;; P04 (*) Find the number of elements of a list.
@export
(defun my-length-rec (lst)
  "get the length of a list recursively"
  (if (null lst)
    0
    (1+ (my-length-rec (rest lst)))))

@export
(defun my-length-ite (lst)
  "get the length of a list iterately"
  (labels ((inner-length (lst n)
             (if (null lst)
               n
               (inner-length (rest lst) (1+ n)))))
    (inner-length lst 0)))

@export
(defun my-length-loop (lst)
  "get the length of a list using loop"
  ;; cannot use count here because it only count forms that are true
  ;; e.g., length of (1 nil) is 2
  (loop for elem in lst
        for i from 1
        maximize i))

;; P05 (*) Reverse a list.
@export
(defun my-reverse-ite (lst)
  "reverse a list iterately"
  (labels ((inner-reverse (lst res)
             (if (null lst)
               res
               (inner-reverse (rest lst) (cons (first lst) res)))))
    (inner-reverse lst nil)))

@export
(defun my-reverse-loop (lst)
  "reverse a list using loop"
  (loop for elem in lst with res
        do (push elem res)
        finally (return res)))

;; P06 (*) Find out whether a list is a palindrome.
@export
(defun palindrome-p (lst)
  "test if the given list is palindrome"
  (equal lst (reverse lst)))

;; P07 (**) Flatten a nested list structure.
@export
(defun flatten (lst)
  "flatten the given list structure"
  (if (listp lst)
    (reduce #'append (mapcar #'flatten lst))
    (list lst)))

;; P08 (**) Eliminate consecutive duplicates of list elements.
@export
(defun my-compress (lst)
  "remove consecutive duplicates in the given list"
  (operate-on-consecutive-duplicates
    lst
    (lambda (lst) (list (first lst)))
    (lambda (r x) (if (equal (first r) x)
                    r
                    (push x r)))))

;; P09 (**) Pack consecutive duplicates of list elements into sublists.
@export
(defun my-pack (lst)
  "pack consecutive duplicates in the given list into sublists"
  (operate-on-consecutive-duplicates
    lst
    (lambda (lst) (list (list (first lst))))
    (lambda (r x) 
      (if (equal (first (first r)) x)
        (push x (first r))
        (push (list x) r))
      r)))

;; P10 (*) Run-length encoding of a list.
;; E.g., (a a a a b c c a a d e e e e) => ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e))
@export
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

@export
(defun run-length-direct (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length relying on result from my-pack"
  (loop for l in (my-pack lst)
        collect `(,(length l) ,(first l))))

;; P11 (*) Modified run-length encoding.
;; P13 (**) Run-length encoding of a list (direct solution).
;; E.g., (a a a a b c c a a d e e e e) => ((4 a) b (2 c) (2 a) d (4 e))
@export
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
          (push x r)))
      r)))

@export
(defun run-length*-direct (lst)
  "pack consecutive duplicates in the given list into pairs of element and its length relying on result from run-length"
  (loop for l in (run-length lst)
        collect (if (= 1 (first l)) (second l) l)))

;; P12 (**) Decode a modified run-length encoded list.
@export
(defun decode-run-length (lst)
  "unpack consecutive duplicates in the given modified run-length encoded list"
   (loop for pr in lst
         append (if (listp pr)
                  (duplicate (first pr) (second pr))
                  (list pr))))

;; P14 (*) Duplicate the elements of a list.
;; E.g.,  (dupli '(a b c c d)) => (a a b b c c c c d d)
@export
(defun my-dupli (lst)
  "duplicate the elements of a list"
  (loop for pr in lst
        append (duplicate 2 pr)))


;; P15 (**) Replicate the elements of a list a given number of times.
;; E.g.,  (repli '(a b c c d) 3) => (a a a bb b c c c c c c d d d)
@export
(defun my-repli (lst cnt)
  (reduce #'append (mapcar #'(lambda (x) (duplicate cnt x)) lst)))

;; P16 (**) Drop every N'th element from a list.
@export
(defun drop-loop (lst n)
  (loop for elem in lst
        for i from 1
        unless (= 0 (mod i n))
        collect elem))

;; P17 (*) Split a list into two parts; the length of the first part is given.
@export
(defun split (lst n)
  (loop for elem in lst
        for i from 0
        with front and end
        do (if (< i n) (push elem front) (push elem end))
        finally (return `(,(nreverse front) ,(nreverse end)))))

;; P18 (**) Extract a slice from a list.
;; Given two indices, I and K, the slice is the list containing the elements between the I'th and K'th element of the original list (both limits included). Start counting the elements with 1.
@export
(defun skip (lst n)
  (loop for sub on lst
        for i from 0
        while (< i n)
        finally (return sub)))

@export
(defun slice (lst start end)
  (if (> start end)
    (error "start of slice cannot be larger than end, we get ~A ~A" start end))
  (first (split (skip lst (1- start)) (1+ (- end start)))))

;; P19 (**) Rotate a list N places to the left.
@export
(defun rotate (lst step)
  ;; mod always return non-negative result for positive divisor as it uses floor 
  (if lst (let ((rem-step (mod step (length lst))))
            (apply #'append (reverse (split lst rem-step))))))

;; P20 (*) Remove the K'th element from a list, counting from 0.
@export
(defun remove-at-rec (lst n)
  "remove-ats the nth element from the list"
  (cond
    ((not lst) nil)
    ((= 0 n) (rest lst))
    (t (cons (first lst) (remove-at-rec (rest lst) (1- n))))))

@export
(defun remove-at-ite (lst n)
  (labels ((inner-remove-at (lst n res)
             (if (not lst)
               res
               (progn
                 (if (not (= 0 n)) (push (first lst) res))
                 (inner-remove-at (rest lst) (1- n) res)))))
    (nreverse (inner-remove-at lst n '()))))

@export
(defun remove-at-loop (lst n)
  (loop for elem in lst
        for i from 0
        unless (= n i)
        collect elem))
