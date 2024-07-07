Class {
	#name : #JibTupleStruct,
	#superclass : #JibPragma,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibTupleStruct class >> inducedParser [
	^ 'tuplestruct' asParser
	, (#blank asParser plus, JibParser id) plus
	==> [ :x | self new "BOGUS" ]
]
