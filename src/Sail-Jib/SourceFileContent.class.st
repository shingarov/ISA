Class {
	#name : #SourceFileContent,
	#superclass : #Object,
	#instVars : [
		'fileIndex',
		'fileName',
		'full',
		'lines'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
SourceFileContent class >> readFile: fileName [
	^self basicNew
		fileName: fileName;
		initialize
]

{ #category : #accessing }
SourceFileContent >> fileIndex [
	^ fileIndex
]

{ #category : #accessing }
SourceFileContent >> fileIndex: anObject [
	fileIndex := anObject
]

{ #category : #accessing }
SourceFileContent >> fileName [
	^ fileName
]

{ #category : #accessing }
SourceFileContent >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
SourceFileContent >> full [
	^ full
]

{ #category : #accessing }
SourceFileContent >> full: anObject [
	full := anObject
]

{ #category : #initialization }
SourceFileContent >> initialize [
	full := fileName asFileReference contents.
	lines := (full lines inject: #()->0 into: [ :soFar :thisLine |
		soFar key, {thisLine -> soFar value}
		-> (soFar value + thisLine size + 1)
	]) key
]

{ #category : #accessing }
SourceFileContent >> lines [
	^ lines
]

{ #category : #accessing }
SourceFileContent >> lines: anObject [
	lines := anObject
]

{ #category : #'instance creation' }
SourceFileContent >> offsetOfLine: l char: c [
	^(lines at: l) value + c
]

{ #category : #'as yet unclassified' }
SourceFileContent >> textHilightedFromLine: l1 char: c1 toLine: l2 char: c2 [
	| txt |
	txt := full asText.
	txt
		addAttribute: TextBackgroundColor yellow
		from: (self offsetOfLine: l1 char: c1) + 1
		to: (self offsetOfLine: l2 char: c2).
	^txt
]
