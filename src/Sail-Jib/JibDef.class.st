Class {
	#name : #JibDef,
	#superclass : #Object,
	#instVars : [
		'loc'
	],
	#category : #'Sail-Jib'
}

{ #category : #initialization }
JibDef >> addTo: aJibProgram [
	self subclassResponsibility
]
