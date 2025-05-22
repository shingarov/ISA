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

{ #category : #accessing }
Instr_Jump >> condition [ 
	^ exp 
]

{ #category : #testing }
Instr_Jump >> isJump [
	^true
]

{ #category : #semantics }
Instr_Jump >> spriteExprContWith: pass [
	| jump |
	
	jump := parent blocks detect:[:block | block range first = target ].
	
	^EIf cond: exp spriteExpr 
	    trueE: jump spriteΛEApp 
	   falseE: pass 
]
{ #category : #accessing }
Instr_Jump >> target [
	^ target
]

{ #category : #printing }
Instr_Jump >> unparseOn: aStream [
	aStream nextPutAll: 'jump '.
	exp unparseOn: aStream.
	aStream nextPutAll: ' goto '.
	target printOn: aStream.

	sourceLoc unparseOn: aStream.
]
