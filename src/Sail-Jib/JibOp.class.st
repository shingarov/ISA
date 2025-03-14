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

{ #category : #parsing }
JibOp class >> inducedParser [
	self assert: self isAbstract not.
	
	^self id asParser trimRight ==> [ :_ | self new ].
]

{ #category : #testing }
JibOp class >> isAbstract [
	^self == JibOp
]

{ #category : #parsing }
JibOp class >> signature [
	"Return this prim's signature (as a synthetic instance of `Def_Val`).
	 This is needed for type unification."
	
	^ self subclassResponsibility 
]
