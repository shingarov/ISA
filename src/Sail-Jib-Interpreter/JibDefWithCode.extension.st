Extension { #name : #JibDefWithCode }

{ #category : #'*Sail-Jib-Interpreter' }
JibDefWithCode >> hasCode [
	^ instrs notNil and:[instrs notEmpty]
]
