Class {
	#name : #'Exp_Kind',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Kind class >> inducedParser [
	^ Exp_Id inducedParser trim "this should be Exp; however, this leads to recursion on the left"
	, 'is' asParser trim
	, JibParser id
	construct: #(exp - id)
]

{ #category : #'Hindley-Milner' }
Exp_Kind >> typeIn: _ [
	^Ty_Bool
]

{ #category : #'Hindley–Milner' }
Exp_Kind >> unifyHmTypesIn: Γ [
	| tyUnion unionDef |
	tyUnion := exp typeIn: Γ.
	(tyUnion isKindOf: Ty_Union) ifFalse: [ Incompatible signal ].
	unionDef := tyUnion typeDef.
	unionDef memberAt: id ifAbsent: [ Incompatible signal ].
	^Γ
]
