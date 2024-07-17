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

{ #category : #'as yet unclassified' }
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
