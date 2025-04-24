Class {
	#name : #'Def_Pragma',
	#superclass : #JibDef,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Pragma class >> inducedParser [
	^($# asParser
	, (PPChoiceParser withAll: (self subclasses collect: #asParser))
	, Character lf asParser
	==> #second
	) trim
]

{ #category : #enumerating }
Def_Pragma >> childrenDo: aBlock [
	"Leaf nodes, nothing to do."
	
]

{ #category : #printing }
Def_Pragma >> unparseOn: aStream [
	super unparseOn: aStream.
	"
	aStream 
		nextPutAll:'...';
		nextPutAll:'...'.
	"

]
