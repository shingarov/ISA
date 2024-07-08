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
	, (JibInstr inducedParser, $; asParser trim ==> #first) star braces trim
	construct: #(- name args body)
]

{ #category : #initialization }
Def_Fn >> addTo: aJibProgram [
	aJibProgram values
		at: name zdecode
		put: self.
	self elaborateIn: aJibProgram
]

{ #category : #'as yet unclassified' }
Def_Fn >> elaborateIn: aJibProgram [
	"self shouldBeImplemented."  "the most interesting thing!"
]
