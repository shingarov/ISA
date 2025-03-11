Class {
	#name : #JibLoc,
	#superclass : #JibProgramNode,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibLoc class >> inducedParser [
	^ Loc_Addr  asParser
	/ Loc_Field asParser
	/ Loc_Id asParser
]

{ #category : #testing }
JibLoc class >> isAbstract [
	^self == JibLoc
]

{ #category : #enumerating }
JibLoc >> defdIdsDo: aBlock [
	"Evaluate `aBlock` for each id in this location"
]
