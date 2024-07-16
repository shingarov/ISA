Class {
	#name : #JibStruct,
	#superclass : #JibDef,
	#instVars : [
		'name',
		'members'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibStruct class >> inducedParser [
	^ 'struct' asParser trim
	, JibParser id trim
	, (JibParser id, $: asParser trim, Ty inducedParser) commaSeparated braces
	construct: #(- name members)
]

{ #category : #printing }
JibStruct >> printOn: aStream [
	aStream
		nextPutAll: 'struct ';
		nextPutAll: name;
		nextPutAll: ' {…}'
]
