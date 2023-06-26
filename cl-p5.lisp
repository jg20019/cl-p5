;;;; cl-p5.lisp

(in-package #:cl-p5)

;;;; SERVER 

(defparameter *acceptor* nil)

(defun start (&optional (port 4242))
  "Start the acceptor on given port"
  (unless (and *acceptor* (hunchentoot:started-p *acceptor*))
    (setf *acceptor* (make-instance 'hunchentoot:easy-acceptor :port port))
    (hunchentoot:start *acceptor*)))

(defun stop () 
  "Stops server if running."
  (when (hunchentoot:started-p *acceptor*)
    (hunchentoot:stop *acceptor*)))

;;; TEMPLATES

(defmacro with-page ((&key title) &body body)
  `(spinneret:with-html-string 
     (:doctype)
     (:html 
       (:head 
        (:title ,title) 
        (:script :src "https://cdn.jsdelivr.net/npm/p5@1.6.0/lib/p5.js")
        (:script :src "/sketch.js" :type "text/javascript"))
       (:body ,@body))))

;;;: ROUTES 

(hunchentoot:define-easy-handler (index :uri "/") () 
  (with-page (:title "CL P5 - Sandbox")))

(hunchentoot:define-easy-handler (sketch :uri "/sketch.js") () 
  (setf (hunchentoot:content-type*) "text/javascript")
  (let ((setup-function (make-setup-function))
        (draw-function (make-draw-function)))
    (concatenate 'string setup-function draw-function)))

(defun make-setup-function () 
  "Called when creating JS to be executed by p5.js. Every call to setup 
   modifies this function thus updating the sketch."
    (parenscript:ps 
       (defun setup ()
         (create-canvas 400 400))))

(defun make-draw-function () 
  "Called when creating JS to be executed by p5.js. Every call to draw 
   modifies this function thus updating the sketch."
    (parenscript:ps 
       (defun draw ()
         (background 220))))

;; TODO Re-evaluating setup/draw methods causes the browser to update. 

;;;; WEBSOCKET
;;;; TODO The idea here is to create a socket/connection to browser.
;;;; It resends the scripts and reloads them in the browser when:
;;;; 1. setup is called
;;;; 2. draw is called
;;;; 3. Environment is changed. Well, because data isn't being sent per se
;;;;    this really triggers #1 and #2
;;;; 4. We could change the code so that data is sent as a fetch when the page
;;;;    loads. That way the setup can reference it, maybe with specific functions 
;;;;    That way setting data changes, what fetch receives.

;;;; TOPLEVEL 

(defmacro setup (&body body) 
  "Define setup function for p5.js"
  `(defun make-setup-function () 
     (parenscript:ps 
       (defun setup ()
         ,@(substitute-variables body)))))

(defmacro draw (&body body) 
  "Define draw function for p5.js"
  `(defun make-draw-function ()
     (parenscript:ps 
       (defun draw ()
         ,@(substitute-variables body)))))

;;;; ENVIRONMENT

(defparameter *env* (make-hash-table))

;; TODO Create a list of reservered words so that users 
;; don't create variables that shadows p5.js function calls

(defun get-var (sym) 
  "Define a variable in the environment"
  (gethash sym *env*))

(defmacro set-var (sym value) 
  "Access value of variable in the environment"
  `(setf (gethash ',sym *env*) ,value))

(defun reset-env () 
  "Clear all environment variables"
  (clrhash *env*))

(defun defined-symbols () 
  "Get list of symbols defined in environment"
  (alexandria:hash-table-keys *env*))

(defun substitute-variables (body) 
  "Replace all occurences of set variables in body. Used when
   creating the setup/draw functions."
  (reduce (lambda (body sym)
            (subst (get-var sym) sym body))
          (defined-symbols)
          :initial-value body))
