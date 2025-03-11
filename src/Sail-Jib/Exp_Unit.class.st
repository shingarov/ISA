Class {
	#name : #'Exp_Unit',
	#superclass : #JibExp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Unit class >> inducedParser [
	^ '()'  asParser ==> [ :_ | Exp_Unit new ]
]

{ #category : #enumerating }
Exp_Unit >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]
