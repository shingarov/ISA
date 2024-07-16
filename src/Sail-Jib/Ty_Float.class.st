Class {
	#name : #'Ty_Float',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Float class >> inducedParser [
	^ '%f' asParser
]
