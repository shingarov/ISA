Extension { #name : #'Exp_Bool' }

{ #category : #'*Sail-Jib-Interpreter' }
Exp_Bool >> interpretIn: interpreter [
	^ interpreter interpretBool: self
]
