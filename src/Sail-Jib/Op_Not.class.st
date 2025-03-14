Class {
	#name : #'Op_Not',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Not class >> id [
	^ '@not'
]

{ #category : #evaluating }
Op_Not >> evaluateWithArguments: args [
	^ args first not
]
