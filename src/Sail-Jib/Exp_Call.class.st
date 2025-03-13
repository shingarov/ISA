Class {
	#name : #'Exp_Call',
	#superclass : #JibExp,
	#instVars : [
		'op',
		'args'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Call class >> inducedParser [
	^ JibOp asParser
	, JibExp asParser commaList
	construct: #(op args)
]

{ #category : #enumerating }
Exp_Call >> childrenDo: aBlock [
	args do: aBlock
	
]

{ #category : #enumerating }
Exp_Call >> usedIdsDo: aBlock [
	args do:[:e|e usedIdsDo: aBlock]
	
]
