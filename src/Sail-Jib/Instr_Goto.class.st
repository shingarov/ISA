Class {
	#name : #'Instr_Goto',
	#superclass : #JibInstr,
	#instVars : [
		'n'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Goto class >> inducedParser [
	^ 'goto' asParser trim
	, (#digit asParser plus flatten ==> #asInteger)
	construct: #(- n)
	
"
Instr_Goto parser parse: 'goto 10'
"
]

{ #category : #testing }
Instr_Goto >> isGoto [
	^true
]

{ #category : #printing }
Instr_Goto >> printOn: aStream [
	aStream nextPutAll: 'goto '.
	n printOn: aStream
]

{ #category : #accessing }
Instr_Goto >> target [
	^n
]
