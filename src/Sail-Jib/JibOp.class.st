Class {
	#name : #JibOp,
	#superclass : #JibProgramNode,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibOp class >> inducedParser [
	^ Op_Neq asParser
	/ Op_Not asParser
]

{ #category : #testing }
JibOp class >> isAbstract [
	^self == JibOp
]
