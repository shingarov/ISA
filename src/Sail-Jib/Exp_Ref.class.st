Class {
	#name : #'Exp_Ref',
	#superclass : #JibExp,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Ref >> childrenDo: aBlock [
	"Leaf node, nothing to do"

]

{ #category : #printing }
Exp_Ref >> unparseOn: aStream [	
	aStream 
		nextPut: $&;
		nextPutAll: id.
	
]
