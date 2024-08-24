Class {
	#name : #JibLoc,
	#superclass : #Object,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibLoc class >> inducedParser [
	^ Loc_Addr  inducedParser
	/ Loc_Field inducedParser
	/ Loc_Id inducedParser
]

{ #category : #enumerating }
JibLoc >> defdIdsDo: aBlock [
	"Evaluate `aBlock` for each id in this location"
]
