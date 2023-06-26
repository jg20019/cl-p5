;;;; package.lisp

(defpackage #:cl-p5
  (:use #:cl) 
  (:export 
    ;; Define toplevel p5.js 
    #:sketch

    ;; Create variables
    #:get-var 
    #:set-var
    #:reset-env

    ;; Running server
    #:start
    #:stop))
