Extension { #name : #'Exp_I128' }

{ #category : #'*Sail-Jib-Interpreter' }
Exp_I128 >> interpretIn: interpreter [
	^ interpreter interpretI128: self
]
