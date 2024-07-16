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
