Class {
	#name : #'Exp_Field',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Field class >> inducedParser [
	^ Exp_Id asParser "this should be Exp; however, this leads to recursion on the left"
	, $. asParser
	, JibParser id
	construct: #(exp - id)
]
