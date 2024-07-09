Class {
	#name : #ExpectForm,
	#superclass : #ParsingState,
	#category : #'GreenCloth-Markdown'
}

{ #category : #logic }
ExpectForm >> transition: l [
	op form: (l copyFrom: 1 to: (l indexOfSubCollection: '-Form' startingAt: 1 ifAbsent: [ self error ])-1).
	^ExpectBlank op: op next: ExpectOpcode 
]
