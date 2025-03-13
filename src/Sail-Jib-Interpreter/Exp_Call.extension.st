Extension { #name : #'Exp_Call' }

{ #category : #'*Sail-Jib-Interpreter' }
Exp_Call >> interpretIn: interpreter [
	^ interpreter interpretCallOp: self
]
