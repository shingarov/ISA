Class {
	#name : #'Loc_Id',
	#superclass : #JibLoc,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Loc_Id class >> inducedParser [
	^ (PPSequenceParser with: JibParser id)
	construct: #(id)
	
"
JibLoc inducedParser parse: 'xyz'
"
]

{ #category : #enumerating }
Loc_Id >> defdIdsDo: aBlock [
	aBlock value: id
]

{ #category : #accessing }
Loc_Id >> id [
	^ id
]

{ #category : #printing }
Loc_Id >> printOn: aStream [
	aStream nextPutAll: id
]
