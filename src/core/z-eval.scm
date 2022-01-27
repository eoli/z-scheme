(load "support/default")


(define (z-eval exp env)
	(cond
		((self-evaluating? exp) exp)
		((variable? exp) (lookup-variable exp env))
		((assignment? exp) 
			(set! env (extend-env
				(list (variable-name exp))
				(list (z-eval (variable-value exp) env))
			env)))
		((defination? exp) (not-implemented "define"))
		((if? exp) 
			(if (z-eval (cadr exp) env)
				(z-eval (caddr exp) env)
				(z-eval (cadddr exp) env)))
		((lambda? exp)
				(make-procedure 
					(lambda-args exp)
					(lambda-body exp)
					env
				))
		((begin? exp) (eval-begin (cdr exp) env))
		((cond? exp) (not-implemented "cond"))
		((application? exp)
			(z-apply (z-eval (operator exp) env)
					(eval-sequence (operands exp) env)))
		(else "error")
	)
)