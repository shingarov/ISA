Class {
	#name : #'Exp_I64',
	#superclass : #JibExp,
	#instVars : [
		'v'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_I64 >> childrenDo: aBlock [
	"Leaf node, nothing to do."
]

{ #category : #accessing }
Exp_I64 >> value [
	^ v
]
