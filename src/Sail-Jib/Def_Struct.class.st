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

{ #category : #printing }
Def_Struct >> printOn: aStream [
	aStream
		nextPutAll: 'struct ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
