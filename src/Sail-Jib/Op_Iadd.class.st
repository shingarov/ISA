Class {
	#name : #'Op_Iadd',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Iadd class >> id [
	^ '@iadd'
]

{ #category : #accessing }
Op_Iadd class >> signature [
	^ self shouldBeImplemented
]

{ #category : #evaluating }
Op_Iadd >> evaluateWithArguments: args [
	^ args first + args second
]
