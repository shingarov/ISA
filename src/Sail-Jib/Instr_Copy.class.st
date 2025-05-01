Class {
	#name : #'Instr_Copy',
	#superclass : #JibInstr,
	#instVars : [
		'l',
		'e'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Copy class >> inducedParser [
	^ JibLoc asParser trim
	, $= asParser trim
	, JibExp asParser
	, JibSourceLoc asParser
	construct: #(l - e sourceLoc)
]

{ #category : #enumerating }
Instr_Copy >> childrenDo: aBlock [
	aBlock value: l.
	aBlock value: e.
	aBlock value: sourceLoc 
	
]

{ #category : #enumerating }
Instr_Copy >> defdIdsDo: aBlock [
	l defdIdsDo: aBlock
	
]

{ #category : #accessing }
Instr_Copy >> expression [
	^e
]

{ #category : #accessing }
Instr_Copy >> location [
	^l
]

{ #category : #printing }
Instr_Copy >> printOn: aStream [
	l printOn: aStream.
	aStream nextPutAll: ' = '.
	e printOn: aStream
]

{ #category : #'as yet unclassified' }
Instr_Copy >> toSpriteExpr: Γ andThen: k [
	^(ELet
		decl: (SpriteDecl
			bind: (SpriteBind id: l id)
			expr: (e toSpriteExpr: Γ))
		expr: (k toSpriteExpr: Γ)) normalizeLetOnLet
]

{ #category : #enumerating }
Instr_Copy >> usedIdsDo: aBlock [
	"BOGUS: look at what is in `e` and `args` instvars, looks like some garbage to me."	
	e isArray ifTrue:[				
		e flattened do:[:x|(x isKindOf: JibExp) ifTrue:[x usedIdsDo: aBlock]]
	] ifFalse:[	
		e usedIdsDo: aBlock
	].
	
]
