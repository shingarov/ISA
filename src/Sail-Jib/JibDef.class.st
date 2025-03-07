Class {
	#name : #JibDef,
	#superclass : #JibProgramNode,
	#instVars : [
		'loc'
	],
	#category : #'Sail-Jib'
}

{ #category : #initialization }
JibDef >> addTo: aJibProgram [
	self subclassResponsibility
]

{ #category : #testing }
JibDef class >> isAbstract [
	^self == JibDef
]
