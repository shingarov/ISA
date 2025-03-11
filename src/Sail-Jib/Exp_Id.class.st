Class {
	#name : #'Exp_Id',
	#superclass : #JibExp,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Id class >> inducedParser [
	^ (PPSequenceParser with: JibParser id)
	construct: #(id)
	
"
JibExp inducedParser parse: 'xyz'
"
]

{ #category : #enumerating }
Exp_Id >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #accessing }
Exp_Id >> id [
	^ id
]

{ #category : #printing }
Exp_Id >> printOn: aStream [
	aStream nextPutAll: id
]

{ #category : #enumerating }
Exp_Id >> usedIdsDo: aBlock [
	aBlock value: id
	
]
