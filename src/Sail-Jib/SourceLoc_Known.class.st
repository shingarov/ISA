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

{ #category : #'accessing - text' }
SourceLoc_Known >> completeSourceFileContents [
	| f content |
	f := '/home/boris/work/REMS/sail/doc/examples/riscv_duopod.sail'.
	^(SourceFileContent readFile: f) fileIndex: file
]

{ #category : #accessing }
SourceLoc_Known >> fileIndex [
	^ file
]

{ #category : #accessing }
SourceLoc_Known >> fileIndex: anObject [
	file := anObject
]

{ #category : #GT }
SourceLoc_Known >> gtInspectorSourceIn: composite [
	composite text
			title: 'Source';
			format: #asText;
			display: [ self textWithHilights ]
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

{ #category : #'accessing - text' }
SourceLoc_Known >> textWithHilights [
	^self completeSourceFileContents
		textHilightedFromLine: line1
		char: char1
		toLine: line2
		char: char2
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
