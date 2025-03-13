Class {
	#name : #'Op_Neq',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Neq class >> id [
	^ '@neq'
]

{ #category : #evaluating }
Op_Neq >> evaluateWithArguments: args [
	^ args first ~= args second
]
