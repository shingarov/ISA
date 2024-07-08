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

{ #category : #accessing }
JibSourceLoc >> char1 [
	^ char1
]

{ #category : #accessing }
JibSourceLoc >> char1: anObject [
	char1 := anObject
]

{ #category : #accessing }
JibSourceLoc >> char2 [
	^ char2
]

{ #category : #accessing }
JibSourceLoc >> char2: anObject [
	char2 := anObject
]

{ #category : #'accessing - text' }
JibSourceLoc >> completeSourceFileContents [
	| f content |
	f := '/home/boris/work/REMS/sail/doc/examples/riscv_duopod.sail'.
	^(SourceFileContent readFile: f) fileIndex: fileIndex
]

{ #category : #accessing }
JibSourceLoc >> fileIndex [
	^ fileIndex
]

{ #category : #accessing }
JibSourceLoc >> fileIndex: anObject [
	fileIndex := anObject
]

{ #category : #GT }
JibSourceLoc >> gtInspectorSourceIn: composite [
	composite text
			title: 'Source';
			format: #asText;
			display: [ self textWithHilights ]
]

{ #category : #accessing }
JibSourceLoc >> line1 [
	^ line1
]

{ #category : #accessing }
JibSourceLoc >> line1: anObject [
	line1 := anObject
]

{ #category : #accessing }
JibSourceLoc >> line2 [
	^ line2
]

{ #category : #accessing }
JibSourceLoc >> line2: anObject [
	line2 := anObject
]

{ #category : #'accessing - text' }
JibSourceLoc >> textWithHilights [
	^self completeSourceFileContents
		textHilightedFromLine: line1
		char: char1
		toLine: line2
		char: char2
]
