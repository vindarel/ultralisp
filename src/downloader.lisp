(defpackage #:ultralisp/downloader
  (:use #:cl)
  (:import-from #:legit)
  (:import-from #:ultralisp/metadata
                #:metadata
                #:read-metadata)
  (:import-from #:uiop
                #:ensure-absolute-pathname
                #:ensure-pathname
                #:ensure-directory-pathname)
  (:export
   #:download))
(in-package ultralisp/downloader)


(defgeneric download (obj dir)
  (:documentation "Downloads something into the given directory.
                   Usually, object will be a metadata holding description of a project."))


(defgeneric make-downloader (source)
  (:documentation "This generic should return a funcallable object which accepts
                   two parameter: urn and directory. This fancallable should fetch
                   project's sources and put them into the source directory.

                   Input argument `source' is a keyword from `source' slot of the metadata object."))


(defun ensure-existing-file (path)
  (ensure-pathname path
                   :want-file t
                   :want-existing t))


(defun ensure-absolute-dirname (path)
  (ensure-directory-pathname
   (ensure-absolute-pathname
    path
    (probe-file "."))))


(defmethod download ((projects-metadata-path string) projects-dir)
  "Downloads sources defined in the metadata-file into the `projects-dir'."
  (download (ensure-existing-file projects-metadata-path)
            projects-dir))


(defmethod download ((metadata metadata) dir)
  (log:info "Downloading" metadata)
  (funcall (make-downloader (ultralisp/metadata:get-source metadata))
           (ultralisp/metadata:get-urn metadata)
           dir))


(defmethod download ((projects-metadata-path pathname) projects-dir)
  "Downloads sources defined in the metadata-file into the `projects-dir'."
  (ensure-existing-file projects-metadata-path)
  (ensure-directories-exist projects-dir)
  
  (log:info "Downloading projects, defined in" projects-metadata-path)
  (loop for metadata in (read-metadata projects-metadata-path)
        do (download metadata
                     projects-dir)))


(defun git-clone-or-update (url dir)
  (let ((repo (legit:init (ensure-absolute-dirname dir)
                          :remote url
                          :if-does-not-exist :clone)))
    ;; Here we are suppressing output from the git binary
    (with-output-to-string (*standard-output*)
      (legit:pull repo))
    ;; return nothing
    (values)))


(defmethod make-downloader ((source (eql :github)))
  (lambda (username/project base-dir)
    (let ((url (format nil "https://github.com/~A.git"
                       username/project))
          (dir (ensure-directory-pathname
                (merge-pathnames (cl-strings:replace-all username/project
                                                         "/"
                                                         "-")
                                 (ensure-directory-pathname base-dir)))))
      (git-clone-or-update url dir))))
