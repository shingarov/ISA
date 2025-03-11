Class {
	#name : #'Exp_I128',
	#superclass : #JibExp,
	#instVars : [
		'v'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_I128 class >> inducedParser [
	^ PPParser decimalInteger
	, $: asParser trim
	, 'i128' asParser trim
	construct: #(v - -)
]

{ #category : #enumerating }
Exp_I128 >> childrenDo: aBlock [
	"Leaf node, nothing to do."
]
