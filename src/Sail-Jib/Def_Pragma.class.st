Class {
	#name : #'Def_Pragma',
	#superclass : #JibDef,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Pragma class >> inducedParser [
	^($# asParser
	, (PPChoiceParser withAll: (self subclasses collect: #inducedParser))
	, Character lf asParser
	==> #second
	) trim
]

{ #category : #initialization }
Def_Pragma >> addTo: aJibProgram [ 
	"self shouldBeImplemented." "BOGUS, I don't know what this is, do nothing for now"
]
