Class {
	#name : #'Def_Files',
	#superclass : #JibDef,
	#instVars : [
		'dict'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Files class >> inducedParser [
	^ 'files ' asParser
	, PPParser doubleQuoted trim plus
	==> [ :x |
		| instance |
		instance := self basicNew.
		x second doWithIndex: [ :fileName :j | instance dict at: j-1 put: fileName ].
		instance
	]
]

{ #category : #enumerating }
Def_Files >> childrenDo: aBlock [
	"Nothing"

]

{ #category : #accessing }
Def_Files >> dict [
	dict isNil ifTrue: [ dict := Dictionary new ].
	^ dict
]

{ #category : #accessing }
Def_Files >> dict: anObject [
	dict := anObject
]

{ #category : #queries }
Def_Files >> isFiles [
	^true
]

{ #category : #printing }
Def_Files >> unparseOn: aStream [
	aStream nextPutAll: 'files '.
	0 to: dict size - 1 do:[:i|
		aStream 
			nextPut: $";
			nextPutAll: (dict at: i);
			nextPut: $";
			space.
	]


]
