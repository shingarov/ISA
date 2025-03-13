Extension { #name : #'Exp_Bits' }

{ #category : #'*Sail-Jib-Interpreter' }
Exp_Bits >> interpretIn: interpreter [
	^ interpreter interpretBits: self
]
