Class {
	#name : #JibProgram,
	#superclass : #Object,
	#instVars : [
		'types',
		'values',
		'enums',
		'structs',
		'unions',
		'registers',
		'sourceFiles'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
JibProgram class >> fromDefs: defs [
	| instance |
	instance := self basicNew.
	defs do: [ :def | def addTo: instance ].
	^instance
]

{ #category : #accessing }
JibProgram >> enums [
	enums isNil ifTrue: [ enums := Dictionary new ].
	^enums
]

{ #category : #accessing }
JibProgram >> enums: anObject [
	enums := anObject
]

{ #category : #accessing }
JibProgram >> registers [
	registers isNil ifTrue: [ registers := Dictionary new ].
	^ registers
]

{ #category : #accessing }
JibProgram >> registers: anObject [
	registers := anObject
]

{ #category : #accessing }
JibProgram >> sourceFiles [
	^ sourceFiles
]

{ #category : #accessing }
JibProgram >> sourceFiles: anObject [
	sourceFiles := anObject
]

{ #category : #accessing }
JibProgram >> structs [
	structs isNil ifTrue: [ structs := Dictionary new ].
	^structs
]

{ #category : #accessing }
JibProgram >> structs: anObject [
	structs := anObject
]

{ #category : #accessing }
JibProgram >> types [
	types isNil ifTrue: [ types := Dictionary new ].
	^ types
]

{ #category : #accessing }
JibProgram >> types: anObject [
	types := anObject
]

{ #category : #accessing }
JibProgram >> unions [
	unions isNil ifTrue: [ unions := Dictionary new ].
	^unions
]

{ #category : #accessing }
JibProgram >> unions: anObject [
	unions := anObject
]

{ #category : #accessing }
JibProgram >> values [
	values isNil ifTrue: [ values := Dictionary new ].
	^values
]

{ #category : #accessing }
JibProgram >> values: anObject [
	values := anObject
]
