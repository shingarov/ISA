Class {
	#name : #'Ty_Union',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Union class >> inducedParser [
	^ '%union' asParser trim
	, JibParser id
	construct: #(- id)
]
