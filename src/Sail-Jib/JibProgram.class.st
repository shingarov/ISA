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
		'sourceFiles',
		'typeEnvironment'
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

{ #category : #GT }
JibProgram >> gtFunsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTable
		title: 'Funs';
		display: [ self values associations ];
			column: 'Key' evaluated: [ :each | each key zdecode ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #GT }
JibProgram >> gtRegistersIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastTable
		title: 'Registers';
		display: [ self registers associations ];
			column: 'Key' evaluated: [ :each | each key zdecode ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #GT }
JibProgram >> gtTypesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTable
		title: 'Types';
		display: [ self types associations ];
			column: 'Key' evaluated: [ :each | each key zdecode ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #accessing }
JibProgram >> registers [
	registers isNil ifTrue: [ registers := Dictionary new ].
	^ registers
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
JibProgram >> types [
	types isNil ifTrue: [ types := Dictionary new ].
	^ types
]

{ #category : #accessing }
JibProgram >> unions [
	unions isNil ifTrue: [ unions := Dictionary new ].
	^unions
]

{ #category : #accessing }
JibProgram >> values [
	values isNil ifTrue: [ values := OrderedDictionary new ].
	^values
]
