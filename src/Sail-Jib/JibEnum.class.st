Class {
	#name : #JibEnum,
	#superclass : #JibDef,
	#instVars : [
		'name',
		'members'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibEnum class >> inducedParser [
	^ 'enum' asParser trim
	, JibParser id trim
	, JibParser id trim commaSeparated braces
	construct: #(- name members)
]

{ #category : #initialization }
JibEnum >> addTo: aJibProgram [ 
	aJibProgram enums
		at: name
		zdecode put: self
]

{ #category : #printing }
JibEnum >> printOn: aStream [
	aStream
		nextPutAll: 'enum ';
		nextPutAll: name;
		nextPutAll: ' {…}'
]
