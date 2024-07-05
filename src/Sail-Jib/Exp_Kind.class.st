Class {
	#name : #'Exp_Kind',
	#superclass : #JibExp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Kind class >> inducedParser [
	^ JibParser id trim "this should be Exp; however, this leads to recursion on the left"
	, 'is' asParser trim
	, JibParser id
]
