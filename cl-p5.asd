;;;; cl-p5.asd

(asdf:defsystem #:cl-p5
  :description "Describe cl-p5 here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria #:hunchentoot #:parenscript #:spinneret)
  :components ((:file "package")
               (:file "cl-p5")))
