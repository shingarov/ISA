Class {
	#name : #'Exp_Unwrap',
	#superclass : #JibExp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Unwrap class >> inducedParser [
	^ JibParser id trim "this should be Exp; however, this leads to recursion on the left"
	, 'as' asParser trim
	, (Context readState: #parentInducedParser)
]
