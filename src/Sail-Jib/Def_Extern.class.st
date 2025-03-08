Class {
	#name : #'Def_Extern',
	#superclass : #'Def_Val',
	#instVars : [
		'ext'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Extern class >> inducedParser [
	^   (
	    'val' asParser trim,
	    JibParser id trim,
	    '=' asParser trim,
	    PPParser doubleQuoted trim,
	    $: asParser trim
	    , Ty asParser trim commaSeparated parens trim
	    , '->' asParser trim
	    , Ty asParser trim
	    construct: #(- id - ext - tys - ty)
	) / (
	    'abstract' asParser
	)
]

{ #category : #printing }
Def_Extern >> printOn: aStream [
	aStream nextPut: (Character codePoint: 16r2197).
	aStream nextPutAll: ext.
	aStream nextPutAll: ' ∷ ('.
	tys do: (□ printOn: aStream) separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ') -> '.
	ty printOn: aStream
]
