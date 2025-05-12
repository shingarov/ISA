Class {
	#name : #'Def_Union',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Union class >> inducedParser [
	| arg |

	arg := JibParser id, $: asParser trim, Ty asParser ==> [ :x | x first -> x last ].

	^ 'union' asParser trim
	, JibParser id trim
	, arg commaSeparated braces
	construct: #(- id ids)
]

{ #category : #enumerating }
Def_Union >> childrenDo: aBlock [	
	ids do:[:arg | aBlock value: arg value].
	
	
]

{ #category : #accessing }
Def_Union >> id [
	^ id
]

{ #category : #testing }
Def_Union >> isDataDef [
	^true
]

{ #category : #semantics }
Def_Union >> spriteData [
	| ctors |
	ctors := ids collectAssociations: [ :ctorName :ctorJibType |
		Ctor
			bind: (SpriteBind id: ctorName)
			funArgs: { ctorJibType spriteRType funArgAssoc: nil }
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
Def_Union >> unparseOn: aStream [
	aStream
		nextPutAll: 'union ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
