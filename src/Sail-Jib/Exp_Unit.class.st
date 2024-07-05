Class {
	#name : #'Exp_Unit',
	#superclass : #JibExp,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Unit class >> inducedParser [
	^ '()'  asParser ==> [ :_ | Exp_Unit uniqueInstance ]
]

{ #category : #'instance creation' }
Exp_Unit class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Exp_Unit class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]
