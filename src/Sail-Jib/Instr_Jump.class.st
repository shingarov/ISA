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
	, JibExp inducedParser trim
	, 'goto' asParser trim
	, PPParser decimalInteger trim
	, JibSourceLoc inducedParser trim
	construct: #(- exp - target sourceLoc)
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
