Class {
	#name : #'Ty_RoundingMode',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_RoundingMode class >> inducedParser [
	^ '%rounding_mode' asParser
]
