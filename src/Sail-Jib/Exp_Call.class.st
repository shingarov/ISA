Class {
	#name : #'Exp_Call',
	#superclass : #JibExp,
	#instVars : [
		'b'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Call class >> inducedParser [
	^ JibOp inducedParser
	, (Context readState: #parentInducedParser) commaList
]
