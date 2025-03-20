Extension { #name : #'Def_Fn' }

{ #category : #'*Sail-Jib-Interpreter' }
Def_Fn >> hasCode [
	^ true
]

{ #category : #'*Sail-Jib-Interpreter' }
Def_Fn >> instrAt: pc [
	^instrs at: pc
]
