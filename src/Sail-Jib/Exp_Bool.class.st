Class {
	#name : #'Exp_Bool',
	#superclass : #JibExp,
	#instVars : [
		'b'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Bool class >> inducedParser [
	^ (PPSequenceParser with: 'true'  asParser ==> [ :_ | Bool true  ])
	/ (PPSequenceParser with: 'false' asParser ==> [ :_ | Bool false ])
	construct: #(b)
]

{ #category : #enumerating }
Exp_Bool >> childrenDo: aBlock [
	"Leaf node, nothing to do."
]
