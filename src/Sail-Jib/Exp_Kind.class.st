Class {
	#name : #'Exp_Kind',
	#superclass : #JibExp,
	#instVars : [
		'exp',
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Kind class >> inducedParser [
	^ Exp_Id asParser trim "this should be Exp; however, this leads to recursion on the left"
	, 'is' asParser trim
	, JibParser id
	construct: #(exp - id)
]

{ #category : #enumerating }
Exp_Kind >> childrenDo: aBlock [
	aBlock value: exp
	
]
