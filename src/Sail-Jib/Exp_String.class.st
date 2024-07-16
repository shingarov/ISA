Class {
	#name : #'Exp_String',
	#superclass : #JibExp,
	#instVars : [
		's'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_String class >> inducedParser [
	^ (PPSequenceParser with: PPParser doubleQuoted)
	construct: #(s)
]
