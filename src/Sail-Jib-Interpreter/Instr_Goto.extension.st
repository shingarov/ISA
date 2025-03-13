Extension { #name : #'Instr_Goto' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Goto >> interpretIn: interpreter [
	^ interpreter interpretGoto: self
]
