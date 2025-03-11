Class {
	#name : #JibProgramNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'parser'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibProgramNode class >> asParser [
	parser isNil ifTrue:[
		"Here we keep the parser around (in class-instance variable
		 'parser' only for as long as we're constructing it. This
		 is needed because the it may ve recursive.

		 In theory we can keep it forever, but then we'd need to flush
		 it each time we change #inducedParser so it is easier to just
		 throw it away each time.
		"

		| p |

		[
			parser := p := PPDelegateParser new.
			parser name: self name.
			parser setParser: (self inducedParser name: self name; yourself).
		] ensure:[
			parser := nil.
		].
		^ p.
	].
	^parser

	"
	JibDef asParser

	parser := nil.
	JibProgramNode allSubclassesDo:[:cls | cls instVarNamed: #parser put: nil ].
	"
]

{ #category : #parsing }
JibProgramNode class >> constructNewFrom: values accordingTo: fields [
	^self basicNew
		initializeFrom: values accordingTo: fields;
		yourself
]

{ #category : #parsing }
JibProgramNode class >> inducedParser [
	"Return a parser that parses this node. Never call this
	 directly from other #inducedParser implementations, use
	 #asParser instead!"
	
	self subclassResponsibility 
]

{ #category : #testing }
JibProgramNode class >> isAbstract [
	^self == JibProgramNode
]

{ #category : #accessing }
JibProgramNode >> children [
	^ OrderedCollection streamContents:[ :children | self childrenDo:[ :child | children nextPut: child ] ].
]

{ #category : #enumerating }
JibProgramNode >> childrenDo: aBlock [
	self subclassResponsibility 
	
]

{ #category : #initialization }
JibProgramNode >> initializeFrom: values accordingTo: spec [
	| instvars |

	instvars := self class allInstVarNames.
	spec with: values do: [:name :value |
		name ~~ #'-' ifTrue:[
			| index |

			index := instvars indexOf: name.
			self instVarAt: index put: value.
		]
	].
	self childrenDo:[:child | child setParent: self ]
]

{ #category : #accessing }
JibProgramNode >> parent [
	^ parent
]

{ #category : #initialization }
JibProgramNode >> setParent: aJibProgramNode [
	self assert:(aJibProgramNode isKindOf: JibProgramNode).
	self assert: parent isNil description: 'Attempting to set parent twice'.
	
	parent := aJibProgramNode 
	
]
