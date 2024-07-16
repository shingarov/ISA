Class {
	#name : #'Ty_Ref',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Ref class >> inducedParser [
	^ '&' asParser
]
