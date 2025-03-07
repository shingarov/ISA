Class {
	#name : #JibOp,
	#superclass : #JibProgramNode,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #testing }
JibOp class >> isAbstract [
	^self == JibOp
]

{ #category : #'instance creation' }
JibOp class >> new [
	self shouldNotImplement
]

{ #category : #accessing }
JibOp class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]
