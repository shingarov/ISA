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
	^ (Exp_Unwrap asParser / Exp_Id asParser) "BOGUS: this should be Exp; however, this leads to recursion on the left"
	, $. asParser
	, JibParser id
	construct: #(exp - id)
]

{ #category : #enumerating }
Exp_Field >> childrenDo: aBlock [
	aBlock value: exp
]
