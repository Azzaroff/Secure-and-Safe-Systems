;; Emacs major mode for editing .ts-files.
;; AS, 21 Feb 1994

(setq auto-mode-alist
      (append (list (cons "\\.ts$" 'ts-mode))
	      auto-mode-alist))

(defvar ts-mode-map nil
  "Keymap used in tt mode.")

(let ((map (make-sparse-keymap)))
  (define-key map "\C-c\C-n" 'ts-number)
  (setq ts-mode-map map))

(defvar ada-indent 2 "*Value is the number of columns to indent in Ada-Mode.")

(defun ts-mode ()
"This is a mode intended to support development of .ts test script
files."
  (interactive)
  (kill-all-local-variables)
  (setq indent-tabs-mode nil)
  (use-local-map ts-mode-map)
  (setq major-mode 'ts-mode)
  (setq mode-name "Test Script")
  (make-local-variable 'comment-column)
  (setq comment-column 41)
  (make-local-variable 'end-comment-column)
  (setq end-comment-column 72)
  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "^$\\|" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)
;  (make-local-variable 'indent-line-function)
;  (setq indent-line-function 'c-indent-line)
  (make-local-variable 'require-final-newline)
  (setq require-final-newline t)
  (make-local-variable 'comment-start)
  (setq comment-start "--")
  (make-local-variable 'comment-end)
  (setq comment-end "\n")
  (make-local-variable 'comment-column)
  (setq comment-column 41)
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "--+ *")
  (make-local-variable 'comment-indent-hook)
  (setq comment-indent-hook 'c-comment-indent)
  (make-local-variable 'parse-sexp-ignore-comments)
  (setq parse-sexp-ignore-comments t)
  (run-hooks 'ada-mode-hook))


(defun ts-number (confirm)
  (interactive "sReally give numbers to all the test cases? (yes or no) ")
  (if (string-equal confirm "yes")
      (progn 
	(goto-char (point-min)) 
	(let ((number 1))
	       (while (search-forward "*****" nil t)
		 (if (looking-at "  *([0-9]+) *")
		     (replace-match (format " (%d) " number))
		   (if (looking-at " *")
		       (replace-match (format " (%d) " number))))
		 (setq number (+ number 1)))))))

