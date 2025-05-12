Class {
	#name : #'Def_Enum',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Enum class >> inducedParser [
	^ 'enum' asParser trim
	, JibParser id trim
	, JibParser id trim commaSeparated braces
	construct: #(- id ids)
]

{ #category : #enumerating }
Def_Enum >> childrenDo: aBlock [
	"Enum has no children, it contains just a list of names."
	
]

{ #category : #accessing }
Def_Enum >> id [
	^ id
]

{ #category : #accessing }
Def_Enum >> ids [
	^ ids
]

{ #category : #testing }
Def_Enum >> isDataDef [
	^true
]

{ #category : #testing }
Def_Enum >> isEnum [
	^ true
]

{ #category : #semantics }
Def_Enum >> spriteData [
	| ctors |
	ctors := ids collect: [ :ctorName |
		Ctor
			bind: (SpriteBind id: ctorName)
			funArgs: {}
			reft: nil
		].
	^Data
		name: id
		vars: #()
		rvars: #()
		ctors: (ctors collect: [ :eachCtor | eachCtor mkCtor: id tvs: {} rvs: {} ])
		inv: Reft new known
]

{ #category : #printing }
Def_Enum >> unparseOn: aStream [
	aStream
		nextPutAll: 'enum ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
