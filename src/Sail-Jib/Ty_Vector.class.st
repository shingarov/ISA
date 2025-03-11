Class {
	#name : #'Ty_Vector',
	#superclass : #Ty,
	#instVars : [
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Vector class >> inducedParser [
	^ '%vec' asParser
	, Ty asParser parens
	construct: #(- ty)
]
