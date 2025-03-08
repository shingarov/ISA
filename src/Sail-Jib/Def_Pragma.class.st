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
