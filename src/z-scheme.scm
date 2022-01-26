(load "core/procedure")
(load "core/z-eval")
(load "core/z-apply")
(load "core/predicate")


(define (lookup-variable var env)
	(cond
		((null? env) (display "[lookup-variable error] variable not found: " var))
		((eq? (caar env) var) (cdar env))
		(else (lookup-variable var (cdr env))))
)

(define (operator exp)
	(car exp))

(define (operands exp)
	(cdr exp))

(define (eval-sequence seq env)
	(cond
		((null? seq) '())
		(else (cons
			(z-eval (car seq) env)
			(eval-sequence (cdr seq) env)
		))
	)
)

(define (variable-name exp)
	(car exp))

(define (variable-value exp)
	(cadr exp))

(define (eval-begin exp env)
	(cond
		((null? (cdr exp))
			(z-eval (car exp) env))
		
		(else
			(begin
				(z-eval (car exp) env)
				(eval-begin (cdr exp) env)
			)
		)
	)
)

(define (user-proc-body procedure)
	(caddr procedure))

(define (user-proc-args procedure)
	(cadr procedure))

(define (user-proc-env procedure)
	(cadddr procedure))

(define (extend-env args values env)
	(if (or (null? args)
			(null? values))
	env
	(cons
		(cons (car args) (car values))
		(extend-env (cdr args) (cdr values) env)))
)


(define global-env 
(list
	(cons '+ +)
	(cons '- -)
	(cons '* *)
	(cons '/ /)
	(cons '? *)
	(cons 'display display)
))

(define (welcome)
	(begin
		(newline)
		(newline)
		(display "Welcome to z-scheme")
		(newline)
		(display "Type ^D to exit."))
	)

(define (irep)
	(welcome)
	(define prompt "✏️ ")
	(define (main-loop)
		(begin
			(newline)
			(display prompt)
			(display (z-eval (read) global-env))
			(main-loop)
		)
	)
	(main-loop)
)
