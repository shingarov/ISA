Class {
	#name : #JibProgramNode,
	#superclass : #Object,
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
JibProgramNode class >> constructNewFrom: anArray accordingTo: fields [
	| inst |
	inst := self basicNew.
	(fields zip: anArray) do: [ :ivarNameAndVal |
				ivarNameAndVal key = #- ifFalse: [ inst instVarNamed: ivarNameAndVal key put: ivarNameAndVal value ] ].
	inst initialize.
	^inst
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
