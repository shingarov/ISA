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
	^ JibLoc inducedParser trim
	, $= asParser trim
	, JibExp inducedParser
	, JibSourceLoc inducedParser optional"??? not according to ir_parser.lalrpop!"
	construct: #(l - e sourceLoc)
]

{ #category : #enumerating }
Instr_Copy >> defdIdsDo: aBlock [
	l defdIdsDo: aBlock
	
]

{ #category : #'deterministic interpretation' }
Instr_Copy >> interpretIn: aContext [
	^(aContext at: l put: (e valueIn: aContext)) incrPC
]

{ #category : #printing }
Instr_Copy >> printOn: aStream [
	l printOn: aStream.
	aStream nextPutAll: ' = '.
	e printOn: aStream
]

{ #category : #'formal semantics' }
Instr_Copy >> toSpriteELetAround: expr in: aJibFnEnvironment [
	^ELet
		decl: (SpriteDecl
			bind: (SpriteBind id: l)
			expr: (EAnn
				expr: (e toSpriteExprIn: aJibFnEnvironment)
				ann: (Val
					symbol: l
					rtype: (aJibFnEnvironment at: l) b bUnknown
					metric: nil )
			)
		)
		expr: expr
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
