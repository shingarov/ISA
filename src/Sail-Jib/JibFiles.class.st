Class {
	#name : #JibFiles,
	#superclass : #JibDef,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibFiles class >> inducedParser [
	^ 'files ' asParser
	, PPParser doubleQuoted trim plus
]
