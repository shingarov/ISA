Extension { #name : #'Instr_Jump' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Jump >> interpretIn: interpreter [
	^ interpreter interpretJump: self
]
