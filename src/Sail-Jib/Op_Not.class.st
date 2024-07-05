Class {
	#name : #'Op_Not',
	#superclass : #JibOp,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Op_Not class >> inducedParser [
	^ '@not' asParser ==> self uniqueInstance
]

{ #category : #'instance creation' }
Op_Not class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Op_Not class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]
