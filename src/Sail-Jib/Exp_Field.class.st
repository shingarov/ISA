Class {
	#name : #'Exp_Field',
	#superclass : #JibExp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Field class >> inducedParser [
	^ Exp_Id asParser
	, ($. asParser, JibParser id ==> #second) plus
]
