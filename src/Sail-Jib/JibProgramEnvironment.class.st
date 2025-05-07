Class {
	#name : #JibProgramEnvironment,
	#superclass : #JibEnvironment,
	#instVars : [
		'context'
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
]

{ #category : #accessing }
JibProgramEnvironment >> parent [
	^ nil
]