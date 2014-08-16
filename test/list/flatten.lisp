;; P07 (**) Flatten a nested list structure.

(in-package #:cl-99-test)

(define-cl-tests
  '(#'flatten)
  `((flatten-simple
      (((()) nil)
       (((1)) (1))
       (((1 2 3 4 5)) (1 2 3 4 5))
       ((("123" 3 "123")) ("123" 3 "123"))))
    (flatten-xyz-single
      ((((x y z)) (x y z))
       ((((()) x y z)) (x y z))
       ((((x) () y z)) (x y z))
       ((((x) y z ())) (x y z))
       ((((x) y (z))) (x y z))
       ((((x) (y z))) (x y z))
       (((((x y)) z)) (x y z))
       (((((x y z)))) (x y z))   
       ((((((x y z))))) (x y z))))
    (flatten-xyz
      ((((() (x y z))) (x y z))
       (((() (x y z) ())) (x y z))
       (((() (x) (y) (z) ())) (x y z))
       (((() ((x) (y) (z)) ())) (x y z))   
       (((() ((x) () () (y ()) () (() z)) ())) (x y z))   
       ((((x) (y z))) (x y z))
       ((((x y) (z))) (x y z))))
    (flatten-random-tree
      ((((7 (6 (4 () 5)) 9 (8) 11 () 13)) (7 6 4 5 9 8 11 13)) ;pre-order traversal
       (((((() 4 5) 6) 7 (8) 9 () 11 13)) (4 5 6 7 8 9 11 13)) ;in-order traveresal
       (((((() 5 4) 6) (8) () 13 11 9 7)) (5 4 6 8 13 11 9 7)) ;post-order traversal
       ))))
