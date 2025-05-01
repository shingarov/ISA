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
	, (Ty asParser trim commaSeparated parens ==> [ :x | x ifNil:#() ])
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

{ #category : #'as yet unclassified' }
Def_Val >> toSpriteAnn [
	^Refl
		symbol: 1 rtype: 2 metric: 3
]
