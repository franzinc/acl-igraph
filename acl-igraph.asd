;;;; acl-igraph.asd
(in-package #:cl-user)

(defpackage #:acl-igraph-system
  (:use #:common-lisp
        #:asdf
        #:asdf-extensions))

(in-package #:acl-igraph-system)

(defsystem #:acl-igraph
  :class franz-system
  :author "Tianyu Gu <gty@franz.com>"
  :depends-on ()
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "grovel")
                 (:file "ffi")
                 (:file "export")))))
