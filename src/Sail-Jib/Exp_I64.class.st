Class {
	#name : #'Exp_I64',
	#superclass : #JibExp,
	#instVars : [
		'v'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_I64 class >> inducedParser [
	^ PPParser decimalInteger
	, ($: asParser trim, 'i64' asParser trim) optional
	construct: #(v -)
]

{ #category : #'Hindley-Milner' }
Exp_I64 >> typeIn: _ [ 
	^Ty_I64 uniqueInstance
]
