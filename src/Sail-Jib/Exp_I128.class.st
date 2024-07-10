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

{ #category : #'Hindley-Milner' }
Exp_I128 >> typeIn: _ [ 
	^Ty_I128 uniqueInstance
]
