Class {
	#name : #'Op_Lt',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Lt class >> id [
	^ '@lt'
]

{ #category : #accessing }
Op_Lt class >> signature [
	^ self shouldBeImplemented
]

{ #category : #evaluating }
Op_Lt >> evaluateWithArguments: args [
	^ args first < args second
]
