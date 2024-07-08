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
	^ Def_Extern inducedParser
	/('val' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty inducedParser trim commaSeparated parens
	, '->' asParser trim
	, Ty inducedParser trim
	construct: #(- id - tys - ty))
]

{ #category : #initialization }
Def_Val >> addTo: aJibProgram [ 
	aJibProgram types
		at: id zdecode
		ifPresent: [ self error: 'cant have mor than one type declaration' ]
		ifAbsentPut: (JibFunctionType dom: tys cod: ty)
]
