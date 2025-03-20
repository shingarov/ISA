Extension { #name : #'Def_Register' }

{ #category : #'*Sail-Jib-Interpreter' }
Def_Register >> hasCode [
	^ self hasInitializer
]

{ #category : #'*Sail-Jib-Interpreter' }
Def_Register >> hasInitializer [
	^ instrs notEmpty
]
