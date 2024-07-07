Class {
	#name : #JibFiles,
	#superclass : #JibDef,
	#instVars : [
		'dict'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibFiles class >> inducedParser [
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
JibFiles >> addTo: aJibProgram [
	aJibProgram sourceFiles: dict
]

{ #category : #accessing }
JibFiles >> dict [
	dict isNil ifTrue: [ dict := Dictionary new ].
	^ dict
]

{ #category : #accessing }
JibFiles >> dict: anObject [
	dict := anObject
]
