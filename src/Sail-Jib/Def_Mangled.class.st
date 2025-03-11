Class {
	#name : #'Def_Mangled',
	#superclass : #'Def_Pragma',
	#instVars : [
		'original',
		'mangled'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Mangled class >> inducedParser [
	^ '#mangled' asParser
	, JibParser id trim
	, JibParser id trim
	construct:#(- original mangled)

"
Def_Mangled asParser parse: '#mangled zSome zSomezIUastzIzKzK'
JibDef asParser parse: '#mangled zSome zSomezIUastzIzKzK'
"
]
