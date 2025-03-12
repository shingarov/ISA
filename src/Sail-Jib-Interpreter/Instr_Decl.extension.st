Extension { #name : #'Instr_Decl' }

{ #category : #'*Sail-Jib-Interpreter' }
Instr_Decl >> interpretIn: interpreter [
	^ interpreter interpretDecl: self
]
