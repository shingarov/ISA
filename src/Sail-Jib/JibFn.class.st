Class {
	#name : #JibFn,
	#superclass : #JibDef,
	#instVars : [
		'name',
		'args',
		'body'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibFn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, JibParser id trim commaList
	, (JibInstr inducedParser, $; asParser trim ==> #first) star braces trim
	construct: #(- name args body)
]

{ #category : #initialization }
JibFn >> addTo: aJibProgram [
	aJibProgram values
		at: name zdecode
		put: self.
	self elaborateIn: aJibProgram
]

{ #category : #'as yet unclassified' }
JibFn >> elaborateIn: aJibProgram [
	"self shouldBeImplemented."  "the most interesting thing!"
]
