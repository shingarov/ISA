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
	, (JibExp asParser commaList trim ==> [ :x|x ifNil:#() ])
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

{ #category : #semantics }
Instr_Call >> spriteExprContWith: k [
	| head tail |

	"For

	...
	zz2 = func(zz1)
	...

	create

	...
	let _tmp1 = zz1;
	let zz2 = func(_tmp1)
	"

	self assert: (lvalue isKindOf: Loc_Id).
	self assert: (args size == 1). "currying"

	tail := ELet
		decl: (SpriteDecl
			bind: (SpriteBind id: lvalue id)
			expr: (ΛEApp
							expr: (EImm imm: (EVar of: f))
							imm: (EVar of: '_tmp1')))
		expr: k.

	head := ELet
		decl: (SpriteDecl
			bind: (SpriteBind id: '_tmp1')
			expr: args first spriteExpr)
		expr: tail.

	^head

]

{ #category : #printing }
Instr_Call >> unparseOn: aStream [
	lvalue unparseOn: aStream.
	aStream nextPutAll: ' = '.
	aStream nextPutAll: f.
	aStream nextPut: $(.
	args do:[:arg | arg unparseOn: aStream ] separatedBy:[aStream nextPutAll: ', '].
	aStream nextPut: $).

	sourceLoc unparseOn: aStream.

]

{ #category : #enumerating }
Instr_Call >> usedIdsDo: aBlock [
	"BOGUS: look at what is in `e` and `args` instvars, looks like some garbage to me."	
	args flattened do:[:e|(e isKindOf: JibExp) ifTrue:[e usedIdsDo: aBlock]]
	
]
