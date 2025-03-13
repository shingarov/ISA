Extension { #name : #'Instr_Call' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Call >> interpretIn: interpreter [
	^interpreter interpretCall: self
]
