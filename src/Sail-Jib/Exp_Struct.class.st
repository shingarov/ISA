Class {
	#name : #'Exp_Struct',
	#superclass : #JibExp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Struct class >> Fexp [
	^ JibParser id trim
	, $= asParser trim
	, (Context readState: #parentInducedParser)
]

{ #category : #syntax }
Exp_Struct class >> inducedParser [
	^ 'struct' asParser trim
	, JibParser id trim
	, self Fexp commaSeparated braces
]
