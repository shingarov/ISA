Class {
	#name : #'Exp_Field',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Field >> childrenDo: aBlock [
	aBlock value: exp
]

{ #category : #semantics }
Exp_Field >> spriteExpr [
	| sty fty match unwrapper |
	
	self assert: (exp type isKindOf: Ty_Struct).
	
	sty := exp type. 
	fty := sty def fieldTypeOf: id.
	
	match := ECase x: 'v' alts: { 
		Alt daCon: sty id
         binds: (sty def fields collect:[:nmAndTy | nmAndTy key = id ifTrue:[SpriteBind id:'f'] ifFalse:[SpriteBind junk]])
          expr: (ΛExpression variable: 'f')
	}.
	
	unwrapper := 
		SpriteDecl
			bind: (SpriteBind id: 'extract_' , id)
			expr: (EAnn
				expr: (EFun mkEFun: { SpriteBind id: 'v' } expr: match)
				ann:  (Val symbol: 'extract_' , id rtype: (sty spriteRType) => (fty spriteRType) metric: nil)).
		
	^ ELet
				decl: unwrapper 
				expr: (ΛEApp mkEApp: (EImm imm: (EVar of: unwrapper bind id)) args: { exp spriteExpr })
]

{ #category : #printing }
Exp_Field >> unparseOn: aStream [
	exp unparseOn: aStream.
	aStream 
		nextPut: $.;
		nextPutAll: id.

]
