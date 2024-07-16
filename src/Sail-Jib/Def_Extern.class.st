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
		at: id
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

{ #category : #'Hindley-Milner' }
Def_Extern >> unifyHmTypesIn: Γ [
	"Def_Extern is a weird two-faced lycanthrope:
	 it is a function-typed value, but it also specifies its type."
	"TODO"  "self shouldBeImplemented."
]
