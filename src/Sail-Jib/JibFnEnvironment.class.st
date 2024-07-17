Class {
	#name : #JibFnEnvironment,
	#superclass : #Object,
	#instVars : [
		'argTypes',
		'tempTypes',
		'programTypes'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation - old' }
JibFnEnvironment class >> argTypes: argTypes tempTypes: tempTypes program: aJibProgram [ 
	^self basicNew
	"TODO: set the guts"
]

{ #category : #'instance creation' }
JibFnEnvironment class >> argTypes: argTypes tempTypes: tempTypes programTypes: programTypes [
	^self basicNew
		argTypes: argTypes;
		tempTypes: tempTypes;
		programTypes: programTypes;
		yourself
]

{ #category : #'instance creation' }
JibFnEnvironment class >> fn: f program: p [
	self shouldBeImplemented.
]

{ #category : #accessing }
JibFnEnvironment >> argTypes [
	^ argTypes
]

{ #category : #accessing }
JibFnEnvironment >> argTypes: anObject [
	argTypes := anObject
]

{ #category : #'as yet unclassified' }
JibFnEnvironment >> at: name [
	^self
		at: name
		ifAbsent: [ KeyNotFound signalFor: name ]
]

{ #category : #'as yet unclassified' }
JibFnEnvironment >> at: name ifAbsent: absentBlock [
	^tempTypes
		at: name
		ifAbsent: [
			argTypes
				at: name
				ifAbsent: [ 
					programTypes
						at: name
						ifAbsent: absentBlock
				]
		]
]

{ #category : #accessing }
JibFnEnvironment >> programTypes [
	^ programTypes
]

{ #category : #accessing }
JibFnEnvironment >> programTypes: anObject [
	programTypes := anObject
]

{ #category : #'as yet unclassified' }
JibFnEnvironment >> returnType [
	^tempTypes at: 'return'
]

{ #category : #'as yet unclassified' }
JibFnEnvironment >> temp: x hasType: t [ 
	self
		at: x
		ifAbsent: [ ^tempTypes at: x put: t ].
	self error: 'duplicate declaration'
]

{ #category : #accessing }
JibFnEnvironment >> tempTypes [
	^ tempTypes
]

{ #category : #accessing }
JibFnEnvironment >> tempTypes: anObject [
	tempTypes := anObject
]
