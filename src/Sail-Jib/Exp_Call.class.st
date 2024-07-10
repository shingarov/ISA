Class {
	#name : #'Exp_Call',
	#superclass : #JibExp,
	#instVars : [
		'op',
		'args'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Call class >> inducedParser [
	^ JibOp inducedParser
	, (Context readState: #parentInducedParser) commaList
	construct: #(op args)
]
