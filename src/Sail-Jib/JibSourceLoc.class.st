Class {
	#name : #JibSourceLoc,
	#superclass : #Object,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibSourceLoc class >> inducedParser [
	^ $` asParser trim
	, (#digit asParser plus flatten trim ==> #asInteger)
	, ((#digit asParser plus flatten ==> #asInteger)
	,  $: asParser
	,  (#digit asParser plus flatten ==> #asInteger)
	,  $- asParser
	,  (#digit asParser plus flatten ==> #asInteger)
	,  $: asParser
	,  (#digit asParser plus flatten ==> #asInteger)) optional


"
JibSourceLoc parser parse: '`1 133:27-133:36'.
JibSourceLoc parser parse: '`1'.
"
]
