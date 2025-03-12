Extension { #name : #'Instr_Init' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Init >> interpretIn: interpreter [
	^ interpreter interpretInit: self
]
