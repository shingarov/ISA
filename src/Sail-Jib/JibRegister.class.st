Class {
	#name : #JibRegister,
	#superclass : #JibDef,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibRegister class >> inducedParser [
	^ 'register' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty inducedParser trim
	, '{BOGUS}' asParser optional
	
	
]
