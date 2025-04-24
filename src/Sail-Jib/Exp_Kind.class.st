Class {
	#name : #'Exp_Kind',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Kind >> childrenDo: aBlock [
	aBlock value: exp
	
]

{ #category : #printing }
Exp_Kind >> unparseOn: aStream [
	exp unparseOn: aStream.
	aStream 
		nextPutAll: ' is ';
		nextPutAll: id.
]
