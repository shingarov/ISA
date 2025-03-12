Extension { #name : #'Instr_Copy' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Copy >> interpretIn: interpreter [
	^ interpreter interpretCopy: self
]
