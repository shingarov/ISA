Class {
	#name : #JibExitCause,
	#superclass : #SharedPool,
	#classVars : [
		'Explicit',
		'MatchFailure'
	],
	#category : #'Sail-Jib'
}

{ #category : #'class initialization' }
JibExitCause class >> initialize [
	"
	JibExitCause initialize
	"
	MatchFailure := JibExitCause basicNew.
	Explicit := JibExitCause basicNew.
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
JibExitCause >> unparseOn: aStream [
	self isExplicit ifTrue: [ ^aStream nextPutAll: 'explicit' ].
	self isMatchFailure ifTrue: [ ^aStream nextPutAll: 'match failure' ].
	self error:'Should not be reached'
]
