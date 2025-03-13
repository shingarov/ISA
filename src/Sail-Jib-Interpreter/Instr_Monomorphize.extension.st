Extension { #name : #'Instr_Monomorphize' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Monomorphize >> interpretIn: interpreter [
	^ interpreter interpretMonomorphize: self
]
