(define (lambda-args exp)
	(cadr exp))

(define (lambda-body exp)
	(caddr exp))

(define (make-procedure proc-arguments proc-body proc-env)
	(list '::user-proc proc-arguments proc-body proc-env))
