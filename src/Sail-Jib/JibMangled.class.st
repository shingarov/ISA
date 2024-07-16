Class {
	#name : #JibMangled,
	#superclass : #JibPragma,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibMangled class >> inducedParser [
	^ 'mangled' asParser
	, (#blank asParser plus, JibParser id) plus
	
	

"
JibPragma parser parse:
String lf,
'#mangled zSome zSomezIbzK',
String lf
"
]
