Class {
	#name : #'Exp_Unwrap',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Unwrap >> childrenDo: aBlock [
	aBlock value: exp
]

{ #category : #semantics }
Exp_Unwrap >> spriteExpr [
	| ty match unwrapper |
	
	self assert: (exp type isKindOf: Ty_Union).
	
	ty := exp type. 
	
	match := ECase x: 'v' alts: (
		ty def members collect:[:nameAndType |
			nameAndType key = id ifTrue:[
				Alt daCon: nameAndType key 
				    binds: { SpriteBind id: 'f' } 
				     expr: (ΛExpression variable: 'f')
			] ifFalse:[
				Alt daCon: nameAndType key 
				    binds: { SpriteBind junk } 				
				     expr: (ΛExpression unknown)			
			]
		]
	).
	
	unwrapper := 
		SpriteDecl
			bind: (SpriteBind id: 'unwrap_' , id)
			expr: (EAnn
				expr: (EFun mkEFun: { SpriteBind id: 'v' } expr: match)
				ann:  (Val symbol: 'unwrap_' , id rtype: (ty spriteRType) => ((ty def memberTypeOf: id) spriteRType) metric: nil)).
		
	^ ELet
				decl: unwrapper 
				expr: (ΛEApp mkEApp: (EImm imm: (EVar of: unwrapper bind id)) args: { exp spriteExpr })
]

{ #category : #accessing }
Exp_Unwrap >> type [
	^ exp type def memberTypeOf: id
]

{ #category : #printing }
Exp_Unwrap >> unparseOn: aStream [
	exp unparseOn: aStream.
	aStream 
		nextPutAll: ' as ';
		nextPutAll: id.

]
