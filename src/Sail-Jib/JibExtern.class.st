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
