Class {
	#name : #JibOp,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
JibOp class >> new [
	self shouldNotImplement
]

{ #category : #accessing }
JibOp class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]
