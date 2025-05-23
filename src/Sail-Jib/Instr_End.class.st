Class {
	#name : #'Instr_End',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_End class >> inducedParser [
	^ 'end' asParser
	==> [ :_ | self new ]
]

{ #category : #enumerating }
Instr_End >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #initialization }
Instr_End >> initialize [
	super initialize.
	sourceLoc := SourceLoc_Unknown new.
]

{ #category : #initialization }
Instr_End >> initializeFrom: values accordingTo: spec [
	self shouldNotImplement.
]

{ #category : #testing }
Instr_End >> isEnd [
	^true
]

{ #category : #semantics }
Instr_End >> spriteExprContWith: mustBeNoSuccessor1 [
	self assert: (mustBeNoSuccessor1 = 'no-successor-1').

	^EImm imm: (EVar of: 'return')
]

{ #category : #printing }
Instr_End >> unparseOn: aStream [
	aStream nextPutAll: 'end'.
]
