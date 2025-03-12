Class {
	#name : #'Instr_Call',
	#superclass : #JibInstr,
	#instVars : [
		'lvalue',
		'f',
		'args'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Call class >> inducedParser [
	^ JibLoc asParser trim
	, $= asParser trim
	, ($$ asParser optional, JibParser id) flatten trim
	, JibExp asParser commaList trim
	, JibSourceLoc asParser
	construct: #(lvalue - f args sourceLoc)
]

{ #category : #accessing }
Instr_Call >> argExprs [
	^ args

]

{ #category : #enumerating }
Instr_Call >> childrenDo: aBlock [
	aBlock value: lvalue.
	args do: aBlock.
	aBlock value: sourceLoc 
	
]

{ #category : #enumerating }
Instr_Call >> defdIdsDo: aBlock [
	lvalue defdIdsDo: aBlock
	
]

{ #category : #accessing }
Instr_Call >> function [
	^ self program lookupFunction: f

]

{ #category : #accessing }
Instr_Call >> location [
	^lvalue
]

{ #category : #printing }
Instr_Call >> printOn: aStream [
	lvalue printOn: aStream.
	aStream nextPutAll: ' = '.
	aStream nextPutAll: f.
	aStream nextPutAll: '(...)'.

]

{ #category : #enumerating }
Instr_Call >> usedIdsDo: aBlock [
	"BOGUS: look at what is in `e` and `args` instvars, looks like some garbage to me."	
	args flattened do:[:e|(e isKindOf: JibExp) ifTrue:[e usedIdsDo: aBlock]]
	
]
