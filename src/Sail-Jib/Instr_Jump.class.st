Class {
	#name : #'Instr_Jump',
	#superclass : #JibInstr,
	#instVars : [
		'exp',
		'target'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Jump class >> inducedParser [
	^ 'jump' asParser trim
	, JibExp asParser trim
	, 'goto' asParser trim
	, PPParser decimalInteger trim
	, JibSourceLoc asParser trim
	construct: #(- exp - target sourceLoc)
]

{ #category : #enumerating }
Instr_Jump >> childrenDo: aBlock [
	aBlock value: exp.
	aBlock value: sourceLoc .
	
]

{ #category : #testing }
Instr_Jump >> isJump [
	^true
]

{ #category : #printing }
Instr_Jump >> printOn: aStream [
	aStream nextPutAll: 'jump '.
	exp printOn: aStream.
	aStream nextPutAll: ' goto '.
	target printOn: aStream
]

{ #category : #accessing }
Instr_Jump >> target [
	^ target
]
