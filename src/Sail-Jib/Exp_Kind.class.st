Class {
	#name : #'Exp_Kind',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Kind >> childrenDo: aBlock [
	aBlock value: exp
	
]

{ #category : #semantics }
Exp_Kind >> spriteExpr [
	| ty match recognizer |
	
	self assert: (exp type isKindOf: Ty_Union).
	
	ty := exp type. 
	
	match := ECase x: 'v' alts: (
		ty def members collect:[:nameAndType |
			Alt daCon: nameAndType key binds: { SpriteBind junk } expr: (ΛExpression bool: (nameAndType key = id))
		]
	).
	
	recognizer := 
		SpriteDecl
			bind: (SpriteBind id: 'is_' , id)
			expr: (EAnn
				expr: (EFun mkEFun: { SpriteBind id: 'v' } expr: match)
				ann:  (Val symbol: 'is_' , id rtype: (ty spriteRType) => (Ty_Bool new spriteRType) metric: nil)).
		
	^ ELet
				decl: recognizer 
				expr: (ΛEApp mkEApp: (EImm imm: (EVar of: recognizer bind id)) args: { exp spriteExpr })
]

{ #category : #printing }
Exp_Kind >> unparseOn: aStream [
	exp unparseOn: aStream.
	aStream 
		nextPutAll: ' is ';
		nextPutAll: id.
]
