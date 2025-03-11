Class {
	#name : #'Ty_Ref',
	#superclass : #Ty,
	#instVars : [
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Ref class >> inducedParser [
	^ $& asParser
	, Ty asParser parens
	construct: #(- ty)
]
