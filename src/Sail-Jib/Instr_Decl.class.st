Class {
	#name : #'Instr_Decl',
	#superclass : #JibInstr,
	#instVars : [
		'id',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Decl class >> inducedParser [
	^ JibParser id
	, $: asParser trim
	, Ty asParser
	, JibSourceLoc asParser
	construct: #(id - ty sourceLoc)

"
Instr_Decl inducedParser parse: 'zz40 : %bool `6 131:25-134:1'
"
]

{ #category : #enumerating }
Instr_Decl >> childrenDo: aBlock [
	aBlock value: ty.
	aBlock value: sourceLoc 
	
]

{ #category : #enumerating }
Instr_Decl >> defdIdsDo: aBlock [
	"Evaluate `aBlock` for each id defined (assigned) by this instruction"

	aBlock value: id
]

{ #category : #accessing }
Instr_Decl >> id [
	^ id
]

{ #category : #semantics }
Instr_Decl >> spriteExprContWith: k [
	^ELet
		decl: (SpriteDecl
			bind: (SpriteBind id: id)
			expr: ΛExpression unknown)
		expr: k
]

{ #category : #printing }
Instr_Decl >> unparseOn: aStream [
	"BOGUS: why id is not Loc_Id?"
	aStream nextPutAll: id.
	aStream nextPutAll: ' : '.
	ty unparseOn: aStream.

	sourceLoc unparseOn: aStream.
]

{ #category : #accessing }
Instr_Decl >> varType [
	^ ty
]
