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
	^ JibParser id trim
	, $= asParser trim
	, JibExp inducedParser
	, JibSourceLoc inducedParser optional"??? not according to ir_parser.lalrpop!"
	construct: #(l - e sourceLoc)
]

{ #category : #'deterministic interpretation' }
Instr_Copy >> interpretIn: aContext [
	^(aContext at: l put: (e valueIn: aContext)) incrPC
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
