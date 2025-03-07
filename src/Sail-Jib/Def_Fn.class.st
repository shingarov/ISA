Class {
	#name : #'Def_Fn',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids',
		'body',
		'Γ'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, JibParser id trim commaList
	, JibFnBody inducedParser trim
	construct: #(- id ids body)
]

{ #category : #initialization }
Def_Fn >> addTo: aJibProgram [
	aJibProgram values
		at: id
		put: self.
	self program: aJibProgram
]

{ #category : #accessing }
Def_Fn >> body [
	^body
]

{ #category : #accessing }
Def_Fn >> instrAt: j [ 
	^body instrs at: j
]

{ #category : #printing }
Def_Fn >> printOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: id zdecode
]

{ #category : #initialization }
Def_Fn >> program: aJibProgram [
	"Now that we know enough, we can construct the type environment."
	| cod_dom cod dom |
	cod_dom := ids
		inject: {aJibProgram typeEnvironment at: id . #()}
		into: [ :soFar :thisArg | {soFar first t . soFar second, {thisArg->soFar first s}} ].
	cod := cod_dom first.
	dom := Dictionary newFromAssociations: cod_dom second.
	
	Γ := JibFnEnvironment
		argTypes: dom
		tempTypes: (Dictionary newFromAssociations: {'return'->cod})
		programTypes: aJibProgram typeEnvironment.
	body addTempsTo: Γ
]

{ #category : #'formal semantics' }
Def_Fn >> returnSort [
	"BOGUS what about currying?"
	^self rtype t sort
]

{ #category : #'formal semantics' }
Def_Fn >> rtype [
	^Γ at: id
]

{ #category : #'formal semantics' }
Def_Fn >> toSpriteAnn [
	| ann bodyExpr efun |
	ann := Refl
		symbol: id
		rtype: self rtype
		metric: nil.
		
	bodyExpr := body toSpriteExprIn: 	Γ.

	efun := ids
		foldr: [ :thisArg :soFar | EFun bind: (SpriteBind id: thisArg) expr: soFar ]
		fromSeed: bodyExpr.
	
	^EAnn
		expr: efun
		ann: ann


]

{ #category : #'formal semantics' }
Def_Fn >> toSpriteDecl [
	body blocks.
	self halt.
	
	^SpriteDecl
		bind: (SpriteBind id: id)
		expr: self toSpriteAnn
]
