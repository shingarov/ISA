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
