Class {
	#name : #'Loc_Addr',
	#superclass : #JibLoc,
	#instVars : [
		'address'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Loc_Addr class >> inducedParser [
	^ Loc_Id asParser
	, $* asParser
	==> [ :x | Loc_Addr with: x first ]
	
"
JibLoc inducedParser parse: 'a*'
"
]

{ #category : #'instance creation' }
Loc_Addr class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Loc_Addr class >> with: address [
	^self basicNew
		address: address;
		yourself
]

{ #category : #accessing }
Loc_Addr >> address [
	^ address
]

{ #category : #accessing }
Loc_Addr >> address: anObject [
	address := anObject
]

{ #category : #enumerating }
Loc_Addr >> childrenDo: aBlock [
	aBlock value: address 
	
]

{ #category : #printing }
Loc_Addr >> unparseOn: aStream [
	address unparseOn: aStream.
	aStream nextPut:$*.


]
