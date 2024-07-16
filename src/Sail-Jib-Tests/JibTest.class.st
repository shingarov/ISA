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

{ #category : #tests }
JibTest >> testExecuteReturn42 [
	| ir |
	ir := self parseFileNamed: self jibExamples / 'return42.ir'.
	self halt
]

{ #category : #'as yet unclassified' }
JibTest >> testExecuteUnify1 [
	| ir |
	ir := self parseFileNamed: self jibExamples / 'unifyId1_p.ir'.
	self halt
]

{ #category : #tests }
JibTest >> testParseDuopod [
	(self parseFileNamed: '/home/boris/work/REMS/duopod.ir') inspect
]
