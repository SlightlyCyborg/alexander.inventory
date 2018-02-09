(defpackage :inventory
  (:use :cl))

(in-package :inventory)

(defparameter my-inventory '())
(defparameter inventory-file "my-inventory.inventory")

(defun add-container (container)
  (push `(,container . ()) my-inventory))

(defun add-item (container item)
  (let ((container (assoc container my-inventory)))
   (if container
       (push item (cdr container)))))

(defun save-inventory (&optional (f-name inventory-file))
  (with-open-file (*standard-output* f-name :direction :output
                                            :if-does-not-exist :create
                                            :if-exists :supersede)
    (print my-inventory)))

(defun load-inventory (&optional (f-name inventory-file))
  (with-open-file (f f-name)
    (setf my-inventory
     (read f))))
