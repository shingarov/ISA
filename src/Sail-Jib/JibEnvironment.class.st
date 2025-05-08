Class {
	#name : #JibEnvironment,
	#superclass : #Object,
	#instVars : [
		'node'
	],
	#category : #'Sail-Jib-Environment'
}

{ #category : #'instance creation' }
JibEnvironment class >> of: aJibProgram [
	^self basicNew
		initializeWithNode: aJibProgram;
		yourself
]

{ #category : #accessing }
JibEnvironment >> context [
	^self parent context
]

{ #category : #initialization }
JibEnvironment >> initializeWithNode: aJibProgramNode [
	node := aJibProgramNode.
]

{ #category : #lookup }
JibEnvironment >> lookupSortForTypename: id [
	^ self parent lookupSortForTypename: id
]

{ #category : #lookup }
JibEnvironment >> lookupSortForUnit [
	^self parent lookupSortForUnit
]

{ #category : #accessing }
JibEnvironment >> node [
	"Return the Jib program node this environment is associated with."

	^ node
]

{ #category : #accessing }
JibEnvironment >> parent [
	^node parent environment 
]
