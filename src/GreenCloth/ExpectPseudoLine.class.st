Class {
	#name : #ExpectPseudoLine,
	#superclass : #ParsingState,
	#category : #'GreenCloth-Markdown'
}

{ #category : #logic }
ExpectPseudoLine >> transition: l [
	l isEmpty ifTrue: [ ^ExpectSpecialHeader new: op ].
	(l beginsWith: '    ') ifFalse: [ self error ].
	op pcode add: (l copyFrom: 5 to: l size).
	^self
]
