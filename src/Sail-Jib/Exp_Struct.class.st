Class {
	#name : #'Exp_Struct',
	#superclass : #JibExp,
	#instVars : [
		'id',
		'fields'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Struct class >> Fexp [
	^ JibParser id trim
	, $= asParser trim
	, JibExp asParser
]

{ #category : #syntax }
Exp_Struct class >> inducedParser [
	| fexp |
	
	fexp := (JibParser id , $= asParser trim , JibExp asParser)
					==> [ :x | x first -> x third ].

	^ 'struct' asParser trim
	, JibParser id trim
	, fexp commaSeparated braces
	construct: #(- id fields)
]

{ #category : #enumerating }
Exp_Struct >> childrenDo: aBlock [
	fields do:[:field | aBlock value: field value ] 
	
]
