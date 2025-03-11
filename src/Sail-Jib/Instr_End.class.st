Class {
	#name : #'Instr_End',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_End class >> inducedParser [
	^ 'end' asParser
	==> [ :_ | self new ]
]

{ #category : #enumerating }
Instr_End >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #testing }
Instr_End >> isEnd [
	^true
]
