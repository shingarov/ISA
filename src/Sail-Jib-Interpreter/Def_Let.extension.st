Extension { #name : #'Def_Let' }

{ #category : #'*Sail-Jib-Interpreter' }
Def_Let >> hasCode [
	^ self hasInitializer
]

{ #category : #'*Sail-Jib-Interpreter' }
Def_Let >> hasInitializer [
	^ instrs notEmpty
]
