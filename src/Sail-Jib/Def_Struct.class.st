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
Def_Struct >> id [
	^ id
]

{ #category : #printing }
Def_Struct >> unparseOn: aStream [
	aStream
		nextPutAll: 'struct ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
