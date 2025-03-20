Class {
	#name : #'Op_Isub',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Isub class >> id [
	^ '@isub'
]

{ #category : #accessing }
Op_Isub class >> signature [
	^ self shouldBeImplemented
]

{ #category : #evaluating }
Op_Isub >> evaluateWithArguments: args [
	^ args first - args second
]
