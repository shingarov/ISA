Class {
	#name : #JibProgramEnvironment,
	#superclass : #Object,
	#instVars : [
		'program'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
JibProgramEnvironment class >> of: aJibProgram [ 
	^self basicNew
		program: aJibProgram;
		yourself
]

{ #category : #accessing }
JibProgramEnvironment >> at: aName [
	^self
		at: aName
		ifAbsent: [KeyNotFound signalFor: aName]

]

{ #category : #accessing }
JibProgramEnvironment >> at: aName ifAbsent: absentBlock [
	^program types
		at: aName
		ifAbsent: absentBlock "TODO: registers, enums etc"

]

{ #category : #private }
JibProgramEnvironment >> program: anObject [
	program := anObject
]
