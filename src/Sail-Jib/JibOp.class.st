Class {
	#name : #JibOp,
	#superclass : #JibPrim,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibOp class >> asParser [
	^PPChoiceParser withAll: (self subclasses collect:#inducedParser)
	
	"
	JibOp asParser plus parse: '@not @neq'
	"
]

{ #category : #utilities }
JibOp class >> create: id [
	"Create new JibOp class for given `id`"

	| clsName cls |

	self assert: id first == $@.

	clsName := ('Op_', (id copyFrom: 2 to: id size) capitalized) asSymbol.
	(Smalltalk includesKey: clsName) ifTrue:[ ^self ].

	cls := JibOp subclass: clsName instanceVariableNames: '' classVariableNames: '' package: self package name asString.
	cls class compile: 'id
	^ ''' , id , '''' classified: #accessing.

	cls class compile: 'signature
	^ self shouldBeImplemented' classified: #accessing.


	cls compile: 'evaluateWithArguments: args
	^ self shouldBeImplemented' classified: #evaluating.

	"
	JibOp create: '@gt'
	"


]

{ #category : #parsing }
JibOp class >> inducedParser [
	self assert: self isAbstract not.
	
	^self id asParser trimRight ==> [ :_ | self new ].
]

{ #category : #testing }
JibOp class >> isAbstract [
	^self == JibOp
]
