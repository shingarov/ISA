Class {
	#name : #JibTupleStruct,
	#superclass : #JibPragma,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibTupleStruct class >> inducedParser [
	^ 'tuplestruct' asParser
	, (#blank asParser plus, JibParser id) plus
	
	

"
JibParser parse:
'#tuplestruct ztuplez3z5i_z5string ztuplez3z5i_z5string0 ztuplez3z5i_z5string1',
String lf
"
]
