Extension { #name : #'Loc_Id' }

{ #category : #'*Sail-Jib-Interpreter' }
Loc_Id >> assign: value in: interpreter [
	interpreter context set: id to: value
]
