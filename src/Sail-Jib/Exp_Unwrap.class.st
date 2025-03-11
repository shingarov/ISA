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
	^ Exp_Id asParser trim "this should be Exp; however, this leads to recursion on the left"
	, 'as' asParser trim
	, JibParser id trim
	construct: #(exp - id)
]

{ #category : #enumerating }
Exp_Unwrap >> childrenDo: aBlock [
	aBlock value: exp
]
