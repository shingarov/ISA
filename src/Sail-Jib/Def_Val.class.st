Class {
	#name : #'Def_Val',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'tys',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Val class >> inducedParser [
	^'val' asParser trim
	, JibParser id trim
	, $: asParser trim
	, (Ty asParser trim commaSeparated parens ==> [ :tys | tys ifNotNil:[tys] ifNil: [ PPFailure message:'Argument type list cannot be empty!' ] ])
	, '->' asParser trim
	, Ty asParser trim
	construct: #(- id - tys - ty)
]

{ #category : #accessing }
Def_Val >> argTypes [
	^ tys
]

{ #category : #enumerating }
Def_Val >> childrenDo: aBlock [
	tys do: aBlock.
	aBlock value: ty.
	
	
]

{ #category : #accessing }
Def_Val >> id [
	^ id
]

{ #category : #testing }
Def_Val >> isVal [
	^ true
]

{ #category : #accessing }
Def_Val >> retType [
	^ ty
]

{ #category : #semantics }
Def_Val >> spriteRType [
	^tys reversed
		inject: ty spriteRType
		into: [ :soFar :thisTime | TFun
				x: String junkSymbol
				s: thisTime spriteRType
				t: soFar ]
]

{ #category : #semantics }
Def_Val >> spriteVal [
	^Val
		symbol: id
		rtype: self spriteRType
		metric: nil
]

{ #category : #printing }
Def_Val >> unparseOn: aStream [
	aStream nextPutAll: 'val '.
	aStream nextPutAll: id.
	aStream nextPutAll: ' : ('.
	tys do: [:e | e unparseOn: aStream] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ') -> '.
	ty unparseOn: aStream
]
