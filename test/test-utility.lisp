(in-package #:cl-99-test)

;; Common functions for tests
(in-package #:cl-99-test)

(defvar *print-details* nil)

(defvar *repli-limit* 8)

(defmacro print-before-return (r)
  (once-only (r)
    `(progn
       (format t "Print: ~A~%" ,r)
       ,r)))

;; Test cases for list operations
(defvar *cases-of-lists-tests*
  '((1 2 3 4 5)
    (1 2)
    (5 5 5)
    (1)
    ("123" 2 "123" x 1.0 y z nil :lalala)
    ()))

(defun generate-list-test-cases (&optional result-func generator verifier-name)
  "Generate test cases for list testing based on given functions. Note that verifier should be given a name symbol instead of the function itself because function objects cannot be dumped into fasl files."
  (let* ((my-func (or generator #'list))
         (data-list (loop for l in *cases-of-lists-tests*
                          collect (cons (funcall my-func l)
                                        (if result-func `(,(funcall result-func l)) nil)))))
    (if verifier-name
      `(,data-list :func ,verifier-name)
      data-list)))

(defun generate-list-test-cases-func-gen (func-gen)
  (loop for l in *cases-of-lists-tests*
        collect (multiple-value-bind (generator verifier) (funcall func-gen)
                  (let ((func (or generator #'list)))
                    (if verifier
                      `(,(funcall func l) :func ,verifier))))))

;; Test cases for problems on consecutive duplicates
(defvar *cases-for-consecutive-duplicates-tests*
  '((() nil)
    ((nil) ((nil 1)))
    ((1) ((1 1)))
    ((1 1) ((1 2)))
    ((1 1 1 1 1) ((1 5)))
    ((1 1 nil 1 1) ((1 2) (nil 1) (1 2)))
    ((nil 1 2 3 3) ((nil 1) (1 1) (2 1) (3 2)))
    ((1 2 3 3 nil) ((1 1) (2 1) (3 2) (nil 1)))
    ((1 1 1 1 1 2) ((1 5) (2 1)))
    (("123" "123") (("123" 2)))
    (("123" 1 1 "123") (("123" 1) (1 2) ("123" 1)))
    ((a a a a b c c a a d e e e e) ((a 4) (b 1) (c 2) (a 2) (d 1) (e 4)))
    ((a a a nil a b c c a a d e e e e) ((a 3) (nil 1) (a 1) (b 1) (c 2) (a 2) (d 1) (e 4))))
  "Define the cases for testing of consecutive duplicates in the format:
   (<input list to the function> ((<elem1> <count of elem1>) (elem2 <count of elem2>) ...))")

(defun generate-cd-test-cases (result-func)
  "Generate test cases for testing of consecutive duplicates."
  (loop for pr in *cases-for-consecutive-duplicates-tests*
        collect `((,(first pr))
                  ,(loop for dup in (second pr)
                         collect (funcall result-func dup)))))

(defun generate-decode-cd-test-cases ()
  "Generate test cases for testing of decoding consecutive duplicates."
  (loop for pr in *cases-for-consecutive-duplicates-tests*
        collect `((,(mapcar #'reverse (second pr))) ,(first pr))))

;; Helper functions for testing
(defun cl-test-data-p (data)
  "Test if the argument is a valid test data pair which should in the format like this:
   ((arg1 arg2 ...)) (then test-data-list must have one verify function) or
   ((arg1 arg2 ...) expect-result) or
   ((arg1 arg2 ...) :func #'verifier)"
  (if nil
    (format t "=> ~A ~A ~A ~A ~%"
            (> 3 (length data))
            (= 3 (length data))
            (equal :func (second data))
            (symbol-function-or-nil (third data))))
  (and (listp data)
       (listp (first data))
       (or (> 3 (length data))
           (and (= 3 (length data))
                (equal :func (second data))
                (symbol-function-or-nil (third data))))))

(defun cl-test-data-list-p (data-list)
  "Test if the argument is a valid list of test data pair. Valid format:
   (data1 data2 ...) or
   ((data1 data2 ...) :func #'verifier)"
  (if (listp data-list)
    (flet ((is-valid (data-list)
             (loop for d in data-list always (cl-test-data-p d))))
      (if (and (= 3 (length data-list))
            (equal :func (second data-list)))
        (values
          (and (is-valid (first data-list))
               (symbol-function-or-nil (third data-list)))
          t)
        (values
          (is-valid data-list)
          nil)))))

(defun call-on-list-of-pairs (pair-func data)
  "Turns data into a list of pairs, then applies the function on the pair list."
  (loop for d in data
        collect (funcall pair-func (first d) (rest d))))

(defun test-cl-func (func data-list)
  "Tests the given func with data list which contains test data."
  (multiple-value-bind (valid is-func-list)
    (cl-test-data-list-p data-list)
    (if (not valid)
      (error "invalid test data list ~A" data-list))
    (let ((lst (if is-func-list (first data-list) data-list))
          (list-func (if is-func-list (symbol-function-or-nil (third data-list)) nil)))
      (flet ((verify (in res)
               (if *print-details*
                 (format t "apply ~A on ~A and verify result with ~A~%" func in (or res list-func)))
               (let ((out (apply func in)))
                 (if (= 1 (length res))
                   (assert-equal (first res) out)
                   ;; verify function defined to a specific test data overrides the global one
                   (let ((verifier (or (symbol-function-or-nil (second res)) list-func)))
                     (if *print-details* (format t "=> ~A ~A ~A~%" in out verifier))
                     (if (not verifier)
                       (error "no verify function defined for ~A" in)
                       (assert-true (funcall verifier in out))))))))
        (call-on-list-of-pairs #'verify lst)))))

(defmacro define-cl-test (func name data-list)
  "Define a test for the given function and test data."
  `(define-test ,name (test-cl-func ,func ,data-list)))

(defmacro inner-define-cl-tests (func name-data-list)
  "Genereates macro for defining multiple cl tests."
  (once-only (func name-data-list)
    `(progn 
       (if *print-details* (format t ":~A ~A~%" ,func (listp ,func)))
       (if *print-details* (format t ".~A~%" ,name-data-list))
       ,(with-gensyms (inner-func)
          `(let ((,inner-func
                   (if (functionp ,func)
                     (list ,func)
                     ,func)))
             (if *print-details* (loop for f in ,inner-func do (format t "+ ~A~%" f)))
             `(list ,@(reduce
                        #'append
                        (call-on-list-of-pairs
                          #'(lambda (name data-list)
                              (flet ((get-case-name (i)
                                       (let ((case-name
                                               (if (< 1 (length ,inner-func))
                                                 (intern (format nil "~A-~A" name (1+ i)))
                                                 name)))
                                         (format t "+~A for ~A~%" case-name (nth i ,inner-func))
                                         case-name)))
                                (print-before-return
                                  (loop for f in ,inner-func
                                      for i from 0
                                      collect `(define-cl-test
                                                 ,f
                                                 ,(get-case-name i)
                                                 ',(first data-list))))))
                          ,name-data-list))))))))

(defmacro define-cl-tests (func name-data-list)
  "Define a set of tests for the given functions and named test data."
  `(execute-macro inner-define-cl-tests ,func ,name-data-list))

(defmacro define-cl-test-named (func-name &rest args)
  `(define-cl-test #',func-name ,func-name ,@args))
