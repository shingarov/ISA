Extension { #name : #'Instr_Arbitrary' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Arbitrary >> interpretIn: interpreter [
	^interpreter interpretArbitrary: self
]
