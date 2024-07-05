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
	^ Loc_Id inducedParser
	, $* asParser
	==> [ :x | Loc_Addr with: (Box with: x first) ]
	
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
