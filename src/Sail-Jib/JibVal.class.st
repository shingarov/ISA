Class {
	#name : #JibVal,
	#superclass : #JibDef,
	#instVars : [
		'id',
		'tys',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibVal class >> inducedParser [
	^ 'val' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty inducedParser trim commaSeparated parens
	, '->' asParser trim
	, Ty inducedParser trim
	construct: #(- id - tys - ty)
]

{ #category : #initialization }
JibVal >> addTo: aJibProgram [ 
	aJibProgram types
		at: id zdecode
		put: self
]
