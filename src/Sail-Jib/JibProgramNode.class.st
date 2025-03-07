Class {
	#name : #JibProgramNode,
	#superclass : #Object,
	#category : #'Sail-Jib'
}

{ #category : #'as yet unclassified' }
JibProgramNode class >> adtSummands [
	^(self subclasses reject: #isAbstract)
		asSortedCollection: [ :a :b | a name <= b name ]
]

{ #category : #'as yet unclassified' }
JibProgramNode class >> constructNewFrom: anArray accordingTo: fields [
	| inst |
	inst := self basicNew.
	(fields zip: anArray) do: [ :ivarNameAndVal |
				ivarNameAndVal key = #- ifFalse: [ inst instVarNamed: ivarNameAndVal key put: ivarNameAndVal value ] ].
	inst initialize.
	^inst
]

{ #category : #'as yet unclassified' }
JibProgramNode class >> inducedParser [
	| dp |
	dp := PPDelegateParser new.
	[ dp setParser: (PPChoiceParser withAll: (self adtSummands collect: #inducedParser)) ]
		runReader: #parentInducedParser
		initialState: dp.
	^dp
]

{ #category : #testing }
JibProgramNode class >> isAbstract [
	^self == JibProgramNode
]
