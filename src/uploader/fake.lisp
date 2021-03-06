(defpackage #:ultralisp/uploader/fake
  (:use #:cl)
  (:import-from #:log4cl)
  (:import-from #:ultralisp/uploader/base
                #:make-uploader)
  (:import-from #:ultralisp/variables
                #:get-dist-dir)
  (:import-from #:metatilities
                #:relative-pathname))
(in-package ultralisp/uploader/fake)


(defmethod make-uploader ((type (eql :fake)))
  (lambda (dir-or-file destination-path)
    (let ((destination-path (relative-pathname (get-dist-dir)
                                               destination-path)))
      (ultralisp/utils:walk-dir (dir-or-file absolute relative)
        (let ((destination (merge-pathnames relative destination-path)))
          (log:info "Copying" absolute "to" destination)
          (ensure-directories-exist destination)
          (uiop:copy-file absolute destination))))))
