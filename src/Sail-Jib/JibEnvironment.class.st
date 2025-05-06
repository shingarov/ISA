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

{ #category : #initialization }
JibEnvironment >> initializeWithNode: aJibProgramNode [
	node := aJibProgramNode.
]

{ #category : #accessing }
JibEnvironment >> node [
	"Return the Jib program node this environment is associated with."

	^ node
]
