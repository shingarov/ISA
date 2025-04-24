Class {
	#name : #'Exp_Id',
	#superclass : #JibExp,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Id >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #accessing }
Exp_Id >> id [
	^ id
]

{ #category : #printing }
Exp_Id >> unparseOn: aStream [
	aStream nextPutAll: id
]

{ #category : #enumerating }
Exp_Id >> usedIdsDo: aBlock [
	aBlock value: id
	
]
