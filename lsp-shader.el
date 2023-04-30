;;; lsp-shader.el --- LSP Clients for ShaderLab  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/lsp-mode/lsp-shader
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.1"))
;; Keywords: convenience shader

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; LSP Clients for ShaderLab.
;;

;;; Code:

(require 'lsp-mode)

(defgroup lsp-shader nil
  "Settings for the ShaderLab Language Server."
  :group 'lsp-mode
  :link '(url-link "https://github.com/lsp-mode/lsp-shader"))

(defcustom lsp-shader-server-path nil
  "Path points for ShaderLab LSP.

This is only for development use."
  :type 'string
  :group 'lsp-shader)

(defun lsp-shader--server-command ()
  "Generate startup command for ShaderLab language server."
  (or (and lsp-shader-server-path
           (list lsp-shader-server-path "--stdio"))
      (list (lsp-package-path 'shader-ls) "--stdio")))

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection #'lsp-shader--server-command)
  :activation-fn (lsp-activate-on "shaderlab")
  :major-modes '(shader-mode)
  :priority -1
  :server-id 'shader-ls))

(add-to-list 'lsp-language-id-configuration '(shader-mode . "shaderlab"))

(provide 'lsp-shader)
;;; lsp-shader.el ends here