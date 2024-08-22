Class {
	#name : #JibInstr,
	#superclass : #Object,
	#instVars : [
		'sourceLoc'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibInstr class >> adtSummands [
	^{
		Instr_Arbitrary.
		Instr_End.
		Instr_Goto.
		Instr_Jump.
		Instr_Monomorphize.
		Instr_Call.
		Instr_Copy.
		Instr_Decl.
		Instr_Exit.
		Instr_Init.
	}
]

{ #category : #enumerating }
JibInstr >> defdIdsDo: aBlock [
	"Evaluate `aBlock` for each id defined (assigned) by this instruction"

]

{ #category : #accessing }
JibInstr >> genSet [
	| s |
	s := Set new.
	self usedIdsDo: [ :e|s add:e ].
	^s

]

{ #category : #'deterministic interpretation' }
JibInstr >> interpretIn: aContext [ 
	^self subclassResponsibility
]

{ #category : #testing }
JibInstr >> isBranch [
	^self isJump or:[self isGoto]
]

{ #category : #testing }
JibInstr >> isEnd [
	^false
]

{ #category : #testing }
JibInstr >> isExit [
	^false
]

{ #category : #testing }
JibInstr >> isGoto [
	^false
]

{ #category : #testing }
JibInstr >> isJump [
	^false
]

{ #category : #accessing }
JibInstr >> killSet [
	| s |
	s := Set new.
	self defdIdsDo: [ :e|s add:e ].
	^s

]

{ #category : #'formal semantics' }
JibInstr >> toSpriteExprIn: aJibProgram [ 
	self subclassResponsibility 
]

{ #category : #enumerating }
JibInstr >> usedIdsDo: aBlock [
	"Evaluate `aBlock` for each id used (read, accessed) by this instruction"

]
