Class {
	#name : #'Loc_Field',
	#superclass : #JibLoc,
	#instVars : [
		'loc',
		'field'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Loc_Field class >> inducedParser [
	^ Loc_Id inducedParser
	, ($. asParser, JibParser id ==> #second) plus
	==> [ :x |
		| root chase |
		root := x first.
		chase := x second.
		chase inject: root into: [ :soFar :thisTime | Loc_Field loc: (Box with: soFar) field: thisTime ] ]
	
"
JibLoc parser parse: 'a.b.c'
"
]

{ #category : #'instance creation' }
Loc_Field class >> loc: l field: f [
	^self basicNew
		loc: l;
		field: f;
		yourself
]

{ #category : #'instance creation' }
Loc_Field class >> new [
	self shouldNotImplement
]

{ #category : #enumerating }
Loc_Field >> defdIdsDo: aBlock [
	loc defdIdsDo: aBlock
	
]

{ #category : #accessing }
Loc_Field >> field [
	^ field
]

{ #category : #accessing }
Loc_Field >> field: anObject [
	field := anObject
]

{ #category : #accessing }
Loc_Field >> loc [
	^ loc
]

{ #category : #accessing }
Loc_Field >> loc: anObject [
	loc := anObject
]

{ #category : #printing }
Loc_Field >> printOn: aStream [
	loc printOn: aStream.
	aStream nextPut:$..
	aStream nextPutAll:field

]
