Class {
	#name : #JibSourceLoc,
	#superclass : #Object,
	#instVars : [
		'fileIndex',
		'line1',
		'char1',
		'line2',
		'char2'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
JibSourceLoc class >> fileIndex: fileIndex points: points [
	points isNil ifTrue: [ ^JibUnknownUniqueSourceLoc u: fileIndex ].
	^self basicNew
		fileIndex: fileIndex;
		line1: points first;
		char1: points second; 
		line2: points third;
		char2: points fourth;
		yourself
]

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
	,  (#digit asParser plus flatten ==> #asInteger)
	   ==> [ :x | {
		             x first.
		             x third.
		             x fifth.
		             x seventh
		             } ]) optional
	==> [ :x | self
			fileIndex: x second
			points: x third ]
]
