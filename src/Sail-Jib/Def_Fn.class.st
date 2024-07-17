Class {
	#name : #'Def_Fn',
	#superclass : #JibDef,
	#instVars : [
		'name',
		'args',
		'body'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, JibParser id trim commaList
	, JibFnBody inducedParser trim
	construct: #(- name args body)
]

{ #category : #initialization }
Def_Fn >> addTo: aJibProgram [
	aJibProgram values
		at: name
		put: self
]

{ #category : #printing }
Def_Fn >> printOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: name zdecode
]
