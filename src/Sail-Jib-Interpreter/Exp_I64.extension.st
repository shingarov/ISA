Extension { #name : #'Exp_I64' }

{ #category : #'*Sail-Jib-Interpreter' }
Exp_I64 >> interpretIn: interpreter [
	^ interpreter interpretI64: self
]
