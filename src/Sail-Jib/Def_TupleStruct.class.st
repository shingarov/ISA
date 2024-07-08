Class {
	#name : #'Def_TupleStruct',
	#superclass : #'Def_Pragma',
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_TupleStruct class >> inducedParser [
	^ 'tuplestruct' asParser
	, (#blank asParser plus, JibParser id) plus
	==> [ :x | self new "BOGUS" ]
]
