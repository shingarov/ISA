Class {
	#name : #'Ty_List',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_List class >> inducedParser [
	^ 'LIST' asParser
]
