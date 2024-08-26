Class {
	#name : #JibExitCause,
	#superclass : #Object,
	#classVars : [
		'Explicit',
		'MatchFailure'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
JibExitCause class >> explicit [
	^Explicit
]

{ #category : #syntax }
JibExitCause class >> inducedParser [
	^ ('match' asParser ==> JibExitCause match K) trim
	/ ('explicit' asParser ==> JibExitCause explicit K) trim
]

{ #category : #'class initialization' }
JibExitCause class >> initialize [
	"
	JibExitCause initialize
	"
	MatchFailure := JibExitCause basicNew.
	Explicit := JibExitCause basicNew.
]

{ #category : #'instance creation' }
JibExitCause class >> match [
	^MatchFailure
]

{ #category : #'instance creation' }
JibExitCause class >> new [
	self shouldNotImplement
]

{ #category : #testing }
JibExitCause >> isExplicit [
	^self = Explicit
]

{ #category : #testing }
JibExitCause >> isMatchFailure [
	^self = MatchFailure
]

{ #category : #printing }
JibExitCause >> printOn: aStream [
	self isExplicit ifTrue: [ ^aStream nextPutAll: 'explicit' ].
	self isMatchFailure ifTrue: [ ^aStream nextPutAll: 'match failure' ].
	self error
]
