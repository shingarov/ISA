Class {
	#name : #'Ty_Vector',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Vector class >> inducedParser [
	^ '%vec' asParser
	, (Context readState: #parentInducedParser) parens
]
