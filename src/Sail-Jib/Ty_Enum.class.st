Class {
	#name : #'Ty_Enum',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Enum class >> inducedParser [
	^ '%enum' asParser trim
	, JibParser id
	construct: #(- id)
]
