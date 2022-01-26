(load "z-scheme")

;; (z-eval '(lambda (x) x) '())
;; (z-eval '((lambda (x) x) 100) '())

;; (z-eval '((lambda (x) (* x 2)) 100) (list (cons '* *)))
;; (z-eval '((lambda (a b) (+ a b)) 100 200) (list (cons '+ +)))


;(lambda (a b) (+ a b))

; (define exp
; (quote
; 	((lambda (a b) 

; 		(+ (* a b b b) 1)

; 	) 100 200)
; )
; )

; (z-eval exp global-env)

(irep)
