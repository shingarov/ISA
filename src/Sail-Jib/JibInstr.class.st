Class {
	#name : #JibInstr,
	#superclass : #JibProgramNode,
	#instVars : [
		'sourceLoc'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibInstr class >> inducedParser [
	^	Instr_Arbitrary asParser
	/	Instr_End asParser
	/	Instr_Goto asParser
	/	Instr_Jump asParser
	/	Instr_Monomorphize asParser
	/	Instr_Call asParser
	/	Instr_Copy asParser
	/	Instr_Decl asParser
	/	Instr_Exit asParser
	/	Instr_Init asParser
]

{ #category : #testing }
JibInstr class >> isAbstract [
	^self == JibInstr
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

{ #category : #inspecting }
JibInstr >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 20>

	| loc |

	loc := self sourceLoc.
	loc isKnown ifTrue:[
		loc gtInspectorSourceIn: composite
	].
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

{ #category : #accessing }
JibInstr >> sourceLoc [
	^ sourceLoc
]

{ #category : #semantics }
JibInstr >> spriteExprContWith: k [
	^self subclassResponsibility
]

{ #category : #enumerating }
JibInstr >> usedIdsDo: aBlock [
	"Evaluate `aBlock` for each id used (read, accessed) by this instruction"
]
