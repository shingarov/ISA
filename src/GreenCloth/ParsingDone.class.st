Class {
	#name : #ParsingDone,
	#superclass : #ParsingState,
	#category : #'GreenCloth-Markdown'
}

{ #category : #logic }
ParsingDone >> isAccepting [ 
	^true
]

{ #category : #logic }
ParsingDone >> transition: l [
	self shouldNotImplement 
]
