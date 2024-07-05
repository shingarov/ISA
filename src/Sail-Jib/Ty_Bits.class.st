Class {
	#name : #'Ty_Bits',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bits class >> inducedParser [
	^ '%bv' asParser
	, #digit asParser plus
]
