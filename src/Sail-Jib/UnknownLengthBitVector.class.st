Class {
	#name : #UnknownLengthBitVector,
	#superclass : #Object,
	#instVars : [
		'v'
	],
	#category : #'Sail-Jib'
}

{ #category : #'as yet unclassified' }
UnknownLengthBitVector class >> with: anInteger [ 
	^self basicNew
		v: anInteger;
		yourself
]

{ #category : #accessing }
UnknownLengthBitVector >> v [
	^ v
]

{ #category : #accessing }
UnknownLengthBitVector >> v: anObject [
	v := anObject
]
