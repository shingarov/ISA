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

{ #category : #enumerating }
Ty_Vector >> childrenDo: aBlock [
	aBlock value: ty
	
]
