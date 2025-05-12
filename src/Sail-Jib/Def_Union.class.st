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

{ #category : #printing }
Def_Union >> unparseOn: aStream [
	aStream
		nextPutAll: 'union ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
