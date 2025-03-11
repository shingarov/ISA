Class {
	#name : #'Ty_List',
	#superclass : #Ty,
	#instVars : [
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_List class >> inducedParser [
	^ '%list' asParser
	, Ty asParser parens
	construct: #(- ty)
]

{ #category : #enumerating }
Ty_List >> childrenDo: aBlock [
	aBlock value: ty
]
