Class {
	#name : #'Def_Fn',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids',
		'instrs'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, JibParser id trim commaList
	, (JibInstr asParser, $; asParser trim ==> #first) star braces
	construct: #(- id ids instrs)
]

{ #category : #printing }
Def_Fn >> printOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: id zdecode
]
