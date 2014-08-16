(in-package #:cl-99-test)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro once-only ((&rest names) &body body)
  (let ((syms (loop for name in names collect (gensym))))
    `(let (,@(loop for sym in syms collect `(,sym (gensym))))
       `(let (,,@(loop for sym in syms for name in names collect ``(,,sym ,,name))) 
          ,(let (,@(loop for name in names for sym in syms collect `(,name ,sym))) 
             ,@body)))))

(defun call-on-list-of-pairs (pair-func data)
  (loop for (x y) in data
        collect (funcall pair-func x y)))

(defun cl-test-data-p (data)
  "Test if the argument is a valid test data pair which should in the format like this:
   ((arg1 arg2 ...) expect-result)"
  (and (listp data)
       (= 2 (length data))
       (listp (first data))))

(defun cl-test-data-list-p (data-list)
  "Test if the argument is a valid list of test data pair."
  (and (listp data-list)
       (loop for d in data-list always (cl-test-data-p d))))

(defun verify-valid-data-list (data-list)
  (if (not (cl-test-data-list-p data-list))
    (error "invalid test data list ~A" data-list))
  t)

(defun test-cl-func (func data-list)
  "Tests the given func with data list which contains test data."
  (if (verify-valid-data-list data-list)
    (call-on-list-of-pairs
      #'(lambda (lst res) 
          (if (not (null *print-details*))
            (format t "apply ~A on ~A expect ~A~%" func lst res))
          (assert-equal res (apply func lst)))
      data-list)))

(defmacro define-cl-test (func name data-list)
   "Define a test for the given function and test data."
  `(define-test ,name (test-cl-func ,func ,data-list)))

(defun define-cl-tests (func name-data-list)
  "Define a set of tests for the given functions and named test data."
  (macrolet ((inner-define (func name-data-list)
               (once-only (func name-data-list)
                 `(progn 
                    ;(format t ":~A ~A~%" ,func (listp ,func))
                    ;(format t ".~A~%" ,name-data-list)
                    (let ((inner-func
                            (if (functionp ,func)
                              (list ,func)
                              ,func)))
                      ;(loop for f in inner-func do (format t "+ ~A~%" f))
                      `(list ,@(reduce
                                 #'append
                                 (call-on-list-of-pairs
                                   #'(lambda (name data-list)
                                       (flet ((get-case-name (i)
                                                (let ((case-name
                                                        (if (< 1 (length inner-func))
                                                          (intern (format nil "~A-~A" name (1+ i)))
                                                          name)))
                                                  (format t "+~A for ~A~%" case-name (nth i inner-func))
                                                  case-name)))
                                         (loop for f in inner-func
                                               for i from 0
                                               collect `(define-cl-test
                                                          ,f
                                                          ,(get-case-name i)
                                                          ',data-list))))
                                   ,name-data-list))))))))
    (inner-define func name-data-list)))
