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
	self halt.
	^instance
]

{ #category : #accessing }
JibProgram >> enums [
	^ enums
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
	^ structs
]

{ #category : #accessing }
JibProgram >> structs: anObject [
	structs := anObject
]

{ #category : #accessing }
JibProgram >> types [
	^ types
]

{ #category : #accessing }
JibProgram >> types: anObject [
	types := anObject
]

{ #category : #accessing }
JibProgram >> unions [
	^ unions
]

{ #category : #accessing }
JibProgram >> unions: anObject [
	unions := anObject
]

{ #category : #accessing }
JibProgram >> values [
	^ values
]

{ #category : #accessing }
JibProgram >> values: anObject [
	values := anObject
]
