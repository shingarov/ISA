Class {
	#name : #'Exp_I',
	#superclass : #JibExp,
	#instVars : [
		'v'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_I >> childrenDo: aBlock [
	"Leaf node, nothing to do."
]

{ #category : #accessing }
Exp_I >> integerValue [
	^ v
]
