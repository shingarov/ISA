Class {
	#name : #ExpectSpecialHeader,
	#superclass : #ParsingState,
	#category : #'GreenCloth-Markdown'
}

{ #category : #logic }
ExpectSpecialHeader >> transition: l [
	l = 'Special Registers Altered:' ifFalse: [ ^self error ].
	^ExpectBlank op: op next: ExpectSpecialRegister 
]
