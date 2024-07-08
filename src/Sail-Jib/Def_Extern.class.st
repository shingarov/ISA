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
	    , Ty inducedParser trim commaSeparated parens trim
	    , '->' asParser trim
	    , Ty inducedParser trim
	    construct: #(- id - ext - tys - ty)
	) / (
	    'abstract' asParser
	)
]

{ #category : #initialization }
Def_Extern >> addTo: aJibProgram [
	super addTo: aJibProgram.
	aJibProgram values
		at: id zdecode
		put: self
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
