Class {
	#name : #'Op_Gt',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Gt class >> id [
	^ '@gt'
]

{ #category : #accessing }
Op_Gt class >> signature [
	^ self shouldBeImplemented
]

{ #category : #evaluating }
Op_Gt >> evaluateWithArguments: args [
	^ args first > args second
]
