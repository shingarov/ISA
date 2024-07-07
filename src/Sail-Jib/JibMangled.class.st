Class {
	#name : #JibMangled,
	#superclass : #JibPragma,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibMangled class >> inducedParser [
	^ 'mangled' asParser
	, (#blank asParser plus, JibParser id) plus
	==> [ :x | self new "BOGUS" ]
]
