Class {
	#name : #JibTest,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Tests'
}

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
JibTest >> testParseDuopod [
	self parseFileNamed: '/home/boris/work/REMS/duopod.ir'
]
