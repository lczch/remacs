(require 'ert)

(ert-deftest coding-system-p ()
  (should (eq t (coding-system-p nil)))
  (should (eq t (coding-system-p 'utf-8)))
  (should (eq nil (coding-system-p "utf-8")))
  (should (eq nil (coding-system-p 'test-coding)))
  (put 'test-coding 'coding-system-define-form "test coding")
  (should (eq t (coding-system-p 'test-coding))))

(ert-deftest check-coding-system ()
  (should (eq nil (check-coding-system nil)))
  (should (eq 'no-conversion (check-coding-system 'no-conversion)))
  (should-error (check-coding-system 'test-coding-system) :type 'coding-system-error)
  (define-coding-system 'test-coding-system "Test coding system" :mnemonic "T" :coding-type 'utf-8)
  (should (eq 'test-coding-system (check-coding-system 'test-coding-system))))

(ert-deftest coding-system-aliases ()
  (should (eq t (listp (coding-system-aliases nil))))
  (should (eq t (equal (coding-system-aliases nil)
                       (coding-system-aliases 'no-conversion))))
  (should-error (coding-system-aliases 'no-such-coding-system) :type 'coding-system-error))
