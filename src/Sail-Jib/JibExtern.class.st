Class {
	#name : #JibExtern,
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ext',
		'tys',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibExtern class >> inducedParser [
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
JibExtern >> addTo: aJibProgram [
	aJibProgram types
		at: id zdecode
		put: tys->ty"BOGUS, must convert to function type".
	aJibProgram values
		at: id zdecode
		put: self
]
