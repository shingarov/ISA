Extension { #name : #'Exp_Id' }

{ #category : #'*Sail-Jib-Interpreter' }
Exp_Id >> interpretIn: interpreter [
	^ interpreter interpretId: self
]
