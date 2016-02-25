;;; ox-jira.el --- an Org mode export backend for JIRA format

;;; Copyright (C) 2016 Stig Brautaset

;; Permission is hereby granted, free of charge, to any person obtaining a
;; copy of this software and associated documentation files (the "Software"),
;; to deal in the Software without restriction, including without limitation
;; the rights to use, copy, modify, merge, publish, distribute, sublicense,
;; and/or sell copies of the Software, and to permit persons to whom the
;; Software is furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;; DEALINGS IN THE SOFTWARE.

;;; Author: Stig Brautaset <stig@brautaset.org>

;; Keywords: outlines, hypermedia, wp

;; This file is NOT part of GNU Emacs.

;;; Version: 0.1-SNAPSHOT

;; Homepage: https://github.com/stig/ox-jira.el

;; Package-Requires: ((org "8.0"))

;;; Code:

(eval-when-compile (require 'cl))
(require 'ox)
(require 'ox-publish)

(org-export-define-backend 'jira
  '((bold . org-jira-bold)
    (paragraph . org-jira-paragraph))
  :menu-entry
  '(?j "Export to JIRA"
       ((?j "As JIRA buffer" org-jira-export-as-jira))))

;;; Transcode functions

(defun org-jira-bold (bold contents info)
  "Transcode BOLD from Org to JIRA.
CONTENTS is the text with bold markup. INFO is a plist holding
contextual information."
  (format "*%s*" contents))

(defun org-jira-paragraph (paragraph contents info)
  "Transcode a PARAGRAPH element from Org to JIRA.
CONTENTS is the contents of the paragraph, as a string.  INFO is
the plist used as a communication channel."
  contents)

(defun org-jira-export-as-jira
    (&optional async subtreep visible-only body-only ext-plist)
  "Export current buffer as a Jira buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, omit header
stuff. (e.g. AUTHOR and TITLE.)

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \"*Org JIRA Export*\", which
will be displayed when `org-export-show-temporary-export-buffer'
is non-nil."
  (interactive)
  (org-export-to-buffer 'jira "*Org JIRA Export*"
    async subtreep visible-only body-only ext-plist))

(provide 'ox-jira)

;;; ox-jira.el ends here