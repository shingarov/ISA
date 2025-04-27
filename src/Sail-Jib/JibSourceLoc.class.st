Class {
	#name : #JibSourceLoc,
	#superclass : #JibProgramNode,
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibSourceLoc class >> inducedParser [
	^ SourceLoc_Known asParser
	/ SourceLoc_UnknownUnique asParser
	/ SourceLoc_Unknown asParser
]

{ #category : #testing }
JibSourceLoc class >> isAbstract [
	^self == JibSourceLoc
]

{ #category : #comparing }
JibSourceLoc >> = another [
	^ self subclassResponsibility
]

{ #category : #enumerating }
JibSourceLoc >> childrenDo: aBlock [
	"Leaf nodes, nothing to do."

]

{ #category : #comparing }
JibSourceLoc >> hash [
	^ self subclassResponsibility
]

{ #category : #testing }
JibSourceLoc >> isKnown [
	^ false

]
