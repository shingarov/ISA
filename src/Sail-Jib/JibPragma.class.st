Class {
	#name : #JibPragma,
	#superclass : #JibDef,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibPragma class >> inducedParser [
	^($# asParser
	, (PPChoiceParser withAll: (self subclasses collect: #inducedParser))
	, Character lf asParser
	==> #second
	) trim
]

{ #category : #initialization }
JibPragma >> addTo: aJibProgram [ 
	"self shouldBeImplemented." "BOGUS, I don't know what this is, do nothing for now"
]
