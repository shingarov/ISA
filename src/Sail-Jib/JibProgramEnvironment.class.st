Class {
	#name : #JibProgramEnvironment,
	#superclass : #JibEnvironment,
	#instVars : [
		'context',
		'unitSort'
	],
	#category : #'Sail-Jib-Environment'
}

{ #category : #accessing }
JibProgramEnvironment >> context [
	^context
]

{ #category : #initialization }
JibProgramEnvironment >> initializeWithNode: aJibProgramNode [
	node := aJibProgramNode.
	context := Z3Context fromDefault.
	unitSort := context mkEnumerationSort: '%unit' 
	                             elements: { '()' }
	                               consts: Cell new
	                              testers: Cell new.	
]

{ #category : #lookup }
JibProgramEnvironment >> lookupSortForUnit [
	^ unitSort 
]

{ #category : #accessing }
JibProgramEnvironment >> parent [
	^ nil
]