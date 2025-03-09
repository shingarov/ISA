Class {
	#name : #JibProgram,
	#superclass : #JibProgramNode,
	#instVars : [
		'defs'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibProgram class >> inducedParser [
	^(PPSequenceParser with: JibDef asParser plus)
	construct: #(defs)

]
