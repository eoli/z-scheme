(define (z-apply procedure arguments)
	(begin

	(cond
		((user-define-proc? procedure)
			(z-eval (user-proc-body procedure)
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
