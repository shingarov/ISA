Extension { #name : #'Instr_End' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_End >> interpretIn: interpreter [
	^ interpreter interpretEnd: self
]
