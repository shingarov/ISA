Class {
	#name : #'Exp_Unwrap',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Unwrap >> childrenDo: aBlock [
	aBlock value: exp
]

{ #category : #accessing }
Exp_Unwrap >> type [
	^ exp type def memberTypeOf: id
]

{ #category : #printing }
Exp_Unwrap >> unparseOn: aStream [
	exp unparseOn: aStream.
	aStream 
		nextPutAll: ' as ';
		nextPutAll: id.

]
