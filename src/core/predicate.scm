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

(define (user-define-proc? procedure)
	(cond 
		((list? procedure) (taged-list? procedure '::user-proc))
		(else #f)
		)
)
