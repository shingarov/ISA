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
