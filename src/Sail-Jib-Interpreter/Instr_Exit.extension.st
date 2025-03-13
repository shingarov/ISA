Extension { #name : #'Instr_Exit' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Exit >> interpretIn: interpreter [
	^ interpreter interpretExit: self
]
