Class {
	#name : #'Def_Mangled',
	#superclass : #'Def_Pragma',
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Mangled class >> inducedParser [
	^ 'mangled' asParser
	, (#blank asParser plus, JibParser id) plus
	==> [ :x | self new "BOGUS" ]
]
