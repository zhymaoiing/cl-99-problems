;; P07 (**) Flatten a nested list structure.

(defun flatten (lst)
  "flatten the given list structure"
  (if (listp lst)
    (reduce #'append (mapcar #'flatten lst))
    (list lst)))

(defun test-func (func data)
  (flet ((test (pr)
           (destructuring-bind (lst res) pr
             (assert-equal res (funcall func lst)))))
    (mapcar #'test data)))

(defun test-flatten (data)
  (test-func #'flatten data))

(define-test test-flatten-simple
             (test-flatten '((() nil)
                             ((1) (1))
                             ((1 2 3 4 5) (1 2 3 4 5))
                             (("123" 3 "123") ("123" 3 "123")))))

(define-test test-flatten-xyz-single
             (test-flatten '(((x y z) (x y z))
                             ((() x y z) (x y z))
                             ((x () y z) (x y z))
                             ((x y z ()) (x y z))
                             ((x y (z)) (x y z))
                             ((x (y z)) (x y z))
                             (((x y) z) (x y z))
                             (((x y z)) (x y z))   
                             ((((x y z))) (x y z)))))

(define-test test-flatten-xyz
             (test-flatten '(((() (x y z)) (x y z))
                             ((() (x y z) ()) (x y z))
                             ((() (x) (y) (z) ()) (x y z))
                             ((() ((x) (y) (z)) ()) (x y z))   
                             ((() ((x) () () (y ()) () (() z)) ()) (x y z))   
                             (((x) (y z)) (x y z))
                             (((x y) (z)) (x y z)))))

(define-test test-flatten-random-tree
             (test-flatten '(((7 (6 (4 () 5)) 9 (8) 11 () 13) (7 6 4 5 9 8 11 13)) ;pre-order traversal
                             ((((() 4 5) 6) 7 (8) 9 () 11 13) (4 5 6 7 8 9 11 13)) ;in-order traveresal
                             ((((() 5 4) 6) (8) () 13 11 9 7) (5 4 6 8 13 11 9 7)) ;post-order traversal
                             )))

