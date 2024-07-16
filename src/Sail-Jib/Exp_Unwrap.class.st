Class {
	#name : #'Exp_Unwrap',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Unwrap class >> inducedParser [
	^ Exp_Id inducedParser trim "this should be Exp; however, this leads to recursion on the left"
	, 'as' asParser trim
	, (Context readState: #parentInducedParser)
	construct: #(exp - id)
]
