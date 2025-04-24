Class {
	#name : #'Exp_Bool',
	#superclass : #JibExp,
	#instVars : [
		'b'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Bool >> childrenDo: aBlock [
	"Leaf node, nothing to do."
]

{ #category : #printing }
Exp_Bool >> unparseOn: aStream [
	b unparseOn: aStream
]

{ #category : #accessing }
Exp_Bool >> value [
	^b
]
