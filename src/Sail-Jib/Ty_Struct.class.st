Class {
	#name : #'Ty_Struct',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Struct class >> inducedParser [
	^ '%struct' asParser trim
	, JibParser id
	construct: #(- id)
]
