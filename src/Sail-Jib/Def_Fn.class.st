Class {
	#name : #'Def_Fn',
	#superclass : #JibDefWithCode,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, (JibParser id trim commaList ==> [ :ids | ids ifNotNil:[ids] ifNil: [ PPFailure message:'Argument name list cannot be empty!' ] ])
	, (JibInstr asParser, $; asParser trim ==> #first) star braces
	construct: #(- id ids instrs)
]

{ #category : #accessing }
Def_Fn >> argNames [
	^ ids
]

{ #category : #enumerating }
Def_Fn >> childrenDo: aBlock [
	instrs do: aBlock
	
]

{ #category : #accessing }
Def_Fn >> id [
	^ id
]

{ #category : #testing }
Def_Fn >> isFn [
	^true
]

{ #category : #accessing }
Def_Fn >> retName [
	^ 'return'
]

{ #category : #accessing }
Def_Fn >> retType [
	^ self signature retType
]

{ #category : #accessing }
Def_Fn >> signature [
	"Return this function's signature (as instance of `Def_Val`)."

	self assert: parent notNil.

	^parent lookupFunctionSignature: id



]

{ #category : #semantics }
Def_Fn >> spriteDecl [
	| sig |
	sig := self signature spriteVal.
	^SpriteDecl
		bind: (SpriteBind id: id)
		expr: (EAnn
			expr: self spriteEFun
			ann: sig)
]

{ #category : #semantics }
Def_Fn >> spriteEFun [
	^ids reversed
		inject: self spriteExpr
		into: [ :expr :argName | EFun bind: (SpriteBind id: argName) expr: expr ]
]

{ #category : #semantics }
Def_Fn >> spriteExpr [
	
	"Compute liveness and live-in and live-out arrays so the values 
	 have fixed order. This is handy when generating Sprite functions
	 for individual basic blocks. A bit of a hack indeed."
	JibFnBodyBlockLiveness compute: self.
	self blocks do:[:block |
		block liveness liveIn: (block liveness liveIn asArray).
		block liveness liveOut: (block liveness liveOut asArray).
	].

	"The body of Sprite function contains 'nested' functions
	 representing individual basic blocks followed by
	 simple call to function representing 'entry' block."
	
	^ self blocks 
		inject: (self blocks first spriteΛEApp)
		into: [ :tail :block |
			ELet 
				decl: block spriteDecl
				expr: tail.
		]
]

{ #category : #printing }
Def_Fn >> unparseOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: id zdecode
]

{ #category : #accessing }
Def_Fn >> varTypeOf: varName [
	| argIdx |
	
	argIdx := ids indexOf: varName.
	argIdx ~~ 0 ifTrue:[
		^ self signature argTypes at: argIdx.
	] ifFalse:[
		"TODO: FIXME: Sorry Boris!"
		instrs do:[:instr |
			(instr isDecl and:[instr id = varName]) ifTrue:[
				^ instr varType.
			]
		]. 
	].

	self error:'No such variable declared: ', varName
]
