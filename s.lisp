(define (taged-list? lst tag)
	(if (null? lst)
		#f
		(eq? (car lst) tag)))

(define (self-evaluating? exp)
	(or
		(string? exp)
		(number? exp)))

(define (variable? exp)
	(symbol? exp))

(define (quoted? exp)
	(taged-list? exp 'quote))


(define (assignment? exp)
	(taged-list? exp 'set!))

(define (defination? exp)
	(taged-list? exp 'define))

(define (if? exp)
	(taged-list? exp 'if))


(define (lambda? exp)
	(taged-list? exp 'lambda))

(define (begin? exp)
	(taged-list? exp 'begin))

(define (cond? exp)
	(taged-list? exp 'cond))

(define (application? exp)
	(list? exp ))

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
			(ieval (car seq) env)
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
			(ieval (car exp) env))
		
		(else
			(begin
				(ieval (car exp) env)
				(eval-begin (cdr exp) env)
			)
		)
	)
)

(define (ieval exp env)
	(cond
		((self-evaluating? exp) exp)
		((variable? exp) (lookup-variable exp env))
		((assignment? exp) 
			(set! env (extend-env
				(list (variable-name exp))
				(list (ieval (variable-value exp) env))
			env)))
		((defination? exp) "defination")
		((if? exp) "if")
		((lambda? exp)
				(make-procedure 
					(lambda-args exp)
					(lambda-body exp)
					env
				))
		((begin? exp) (eval-begin (cdr exp) env))
		((cond? exp) "cond")
		((application? exp) ;(add '(1 2))
			(iapply (ieval (operator exp) env)
					(eval-sequence (operands exp) env)))
		(else "error")
	)
)

;; (ieval '(lambda (x) x) '())
;; (ieval '((lambda (x) x) 100) '())

;; (ieval '((lambda (x) (* x 2)) 100) (list (cons '* *)))
;; (ieval '((lambda (a b) (+ a b)) 100 200) (list (cons '+ +)))


;(lambda (a b) (+ a b))
(define (lambda-args exp)
	(cadr exp))

(define (lambda-body exp)
	(caddr exp))

(define (make-procedure proc-arguments proc-body proc-env)
	(list '::user-proc proc-arguments proc-body proc-env))

(define (ieval2 exp)
		(ieval exp '()))

(define (user-define-proc? procedure)
	(cond 
		((list? procedure) (taged-list? procedure '::user-proc))
		(else #f)
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

(define (iapply procedure arguments)
	(begin

	(cond
		((user-define-proc? procedure)
			(ieval (user-proc-body procedure)
					(extend-env
						(user-proc-args procedure)
						arguments
						(user-proc-env procedure)
					))
		)

		(else 
			(apply procedure arguments)
		); primitive procedure
	)
	)
	
)


(define global-env 
(list
	(cons '+ +)
	(cons '- -)
	(cons '* *)
	(cons '/ /)
	(cons '? *)
	(cons 'display display)
	(cons 'list +)
	(cons 'monkey (lambda (x) (* x 10000000000)))
	(cons 'power (lambda (x) (* x x)))
))

(define exp
(quote
	((lambda (a b) 

		(monkey (* a b b b))

	) 100 200)
)
)

(ieval exp global-env)


(define (irep)
	(define prompt "✏️ ")
	(define (main-loop)
		(begin
			(newline)
			(display prompt)
			(display (ieval (read) global-env))
			(main-loop)
		)
	)
	(main-loop)
)

(irep)
