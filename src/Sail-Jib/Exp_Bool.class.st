Class {
	#name : #'Exp_Bool',
	#superclass : #JibExp,
	#instVars : [
		'b'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Bool >> childrenDo: aBlock [
	"Leaf node, nothing to do."
]

{ #category : #accessing }
Exp_Bool >> value [
	^b
]
