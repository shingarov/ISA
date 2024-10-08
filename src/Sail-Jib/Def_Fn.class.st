Class {
	#name : #'Def_Fn',
	#superclass : #JibDef,
	#instVars : [
		'name',
		'args',
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
	construct: #(- name args body)
]

{ #category : #initialization }
Def_Fn >> addTo: aJibProgram [
	aJibProgram values
		at: name
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
		nextPutAll: name zdecode
]

{ #category : #initialization }
Def_Fn >> program: aJibProgram [
	"Now that we know enough, we can construct the type environment."
	| cod_dom cod dom |
	cod_dom := args
		inject: {aJibProgram typeEnvironment at: name . #()}
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
	^Γ at: name
]

{ #category : #'formal semantics' }
Def_Fn >> toSpriteAnn [
	| ann bodyExpr efun |
	ann := Refl
		symbol: name
		rtype: self rtype
		metric: nil.
		
	bodyExpr := body toSpriteExprIn: 	Γ.

	efun := args
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
		bind: (SpriteBind id: name)
		expr: self toSpriteAnn
]
