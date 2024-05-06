;;;; export.cl
(in-package #:acl-igraph)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (do-symbols (sym)
    (when (match-re "^\\+?igraph[_|-]" (symbol-name sym) :case-fold t)
      (export sym))))
