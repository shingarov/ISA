Class {
	#name : #JibTest,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibTest >> jibExamples [
	^self class definingGitDirectory / 'examples' / 'Jib'
]

{ #category : #tests }
JibTest >> parseExampleFileNamed: relativeFileName [
	^self parseFileNamed: self jibExamples / relativeFileName
]

{ #category : #tests }
JibTest >> parseFileNamed: fileName [
	^self parseString: fileName asFileReference contents
]

{ #category : #tests }
JibTest >> parseString: s [
	| jp |
	jp := JibParser new parse: s.
	self assert: (jp isKindOf: JibProgram).
	^jp
]
