Class {
	#name : #'Def_Val',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'tys',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Val class >> inducedParser [
	^'val' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty asParser trim commaSeparated parens
	, '->' asParser trim
	, Ty asParser trim
	construct: #(- id - tys - ty)
]
