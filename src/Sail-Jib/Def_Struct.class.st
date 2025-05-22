Class {
	#name : #'Def_Struct',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Struct class >> inducedParser [
	| arg |

	arg := JibParser id, $: asParser trim, Ty asParser ==> [ :x | x first -> x last ].

	^ 'struct' asParser trim
	, JibParser id trim
	, arg commaSeparated braces
	construct: #(- id ids)
]

{ #category : #enumerating }
Def_Struct >> childrenDo: aBlock [
	ids do:[:arg | aBlock value: arg value].
	
]

{ #category : #accessing }
Def_Struct >> fieldTypeOf: name [
	^(self fields detect:[:nmAndTy | nmAndTy key = name ]) value
]

{ #category : #accessing }
Def_Struct >> fields [ 
	^ids
]

{ #category : #accessing }
Def_Struct >> id [
	^ id
]

{ #category : #testing }
Def_Struct >> isDataDef [
	^true
]

{ #category : #testing }
Def_Struct >> isStruct [
	^ true
]

{ #category : #semantics }
Def_Struct >> spriteData [
	| ctor |
	ctor := Ctor
			bind: (SpriteBind id: id, '__constructor')
			funArgs: (ids collectAssociations: [ :name :ty | ty spriteRType funArgAssoc: name ])
			reft: nil.
	^Data
		name: id
		vars: #()
		rvars: #()
		ctors: {ctor mkCtor: id tvs: {} rvs: {}}
		inv: Reft new known
]

{ #category : #printing }
Def_Struct >> unparseOn: aStream [
	aStream
		nextPutAll: 'struct ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
