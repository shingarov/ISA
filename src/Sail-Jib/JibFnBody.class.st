Class {
	#name : #JibFnBody,
	#superclass : #Object,
	#instVars : [
		'instrs'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibFnBody class >> inducedParser [
	^ (PPSequenceParser with: (JibInstr inducedParser, $; asParser trim ==> #first) star braces)
	construct: #(instrs)
]
