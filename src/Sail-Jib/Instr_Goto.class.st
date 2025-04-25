Class {
	#name : #'Instr_Goto',
	#superclass : #JibInstr,
	#instVars : [
		'n'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Goto class >> inducedParser [
	^ 'goto' asParser trim
	, (#digit asParser plus flatten ==> #asInteger)
	construct: #(- n)
	
"
Instr_Goto parser parse: 'goto 10'
"
]

{ #category : #enumerating }
Instr_Goto >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #initialization }
Instr_Goto >> initializeFrom: values accordingTo: spec [
	self assert: (spec includes: #sourceLoc) not.

	super initializeFrom: values accordingTo: spec.
	sourceLoc := SourceLoc_Unknown new.
]

{ #category : #testing }
Instr_Goto >> isGoto [
	^true
]

{ #category : #accessing }
Instr_Goto >> target [
	^n
]

{ #category : #printing }
Instr_Goto >> unparseOn: aStream [
	aStream nextPutAll: 'goto '.
	n printOn: aStream.
]
