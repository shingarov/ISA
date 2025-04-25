Class {
	#name : #'SourceLoc_Known',
	#superclass : #JibSourceLoc,
	#instVars : [
		'file',
		'line1',
		'char1',
		'line2',
		'char2'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
SourceLoc_Known class >> inducedParser [
	| nat |

	nat := #digit asParser plus flatten trim ==> #asInteger.

	^ $` asParser trim
	, nat
	, nat , $: asParser , nat
	, $- asParser
	, nat , $: asParser , nat
	construct: #(- file line1 - char1 - line2 - char2)

]

{ #category : #accessing }
SourceLoc_Known >> char1 [
	^ char1
]

{ #category : #accessing }
SourceLoc_Known >> char1: anObject [
	char1 := anObject
]

{ #category : #accessing }
SourceLoc_Known >> char2 [
	^ char2
]

{ #category : #accessing }
SourceLoc_Known >> char2: anObject [
	char2 := anObject
]

{ #category : #accessing }
SourceLoc_Known >> file [
	^ self program lookupFile: file
]

{ #category : #accessing }
SourceLoc_Known >> fileIndex [
	^ file
]

{ #category : #accessing }
SourceLoc_Known >> fileIndex: anObject [
	file := anObject
]

{ #category : #inspecting }
SourceLoc_Known >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite text
			title: 'Source';
			display: [ self sourceTextWithHighlights ];
			format: #asText
]

{ #category : #testing }
SourceLoc_Known >> isKnown [
	^ true

]

{ #category : #accessing }
SourceLoc_Known >> line1 [
	^ line1
]

{ #category : #accessing }
SourceLoc_Known >> line1: anObject [
	line1 := anObject
]

{ #category : #accessing }
SourceLoc_Known >> line2 [
	^ line2
]

{ #category : #accessing }
SourceLoc_Known >> line2: anObject [
	line2 := anObject
]

{ #category : #accessing }
SourceLoc_Known >> source [
	"Return the (Sail) source as String or nil if source file is not available."

	| f |

	f := self file.
	f exists ifTrue:[
		^f contents.
	].
	^ nil
]

{ #category : #accessing }
SourceLoc_Known >> sourceText [
	| source |

	source := self source.
	source notNil ifTrue:[
		^source asText.
	].
	^ nil
]

{ #category : #accessing }
SourceLoc_Known >> sourceTextWithHighlights [
	| source |

	source := self sourceText.
	source notNil ifTrue:[
		| start end line |

		line := 1.
		source string lineIndicesDo: [:lineStart :lineEnd :lineEndIncludingNl |
			line == line1 ifTrue:[
				start := lineStart + char1.
			].
			line == line2 ifTrue:[
				end := lineStart + char2 - 1.
				source addAttribute: TextBackgroundColor yellow from: start to: end.
				source addAttribute: TextColor black from: start to: end.
				^ source.
			].
			line := line + 1.
		].
	].
	^ source.
]

{ #category : #printing }
SourceLoc_Known >> unparseOn: aStream [	
	aStream space; space.
	aStream nextPut:$`.
	file printOn: aStream.
	aStream space.
	line1 printOn: aStream. aStream nextPut: $:. char1 printOn: aStream.
	aStream nextPut:$-.	
	line2 printOn: aStream. aStream nextPut: $:. char2 printOn: aStream


]
