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

{ #category : #adding }
Def_Files >> addTo: aJibProgram [
	aJibProgram sourceFiles: dict
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
