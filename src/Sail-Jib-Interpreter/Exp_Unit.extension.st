Extension { #name : #'Exp_Unit' }

{ #category : #'*Sail-Jib-Interpreter' }
Exp_Unit >> interpretIn: interpreter [
	^ interpreter interpretUnit: self
]
