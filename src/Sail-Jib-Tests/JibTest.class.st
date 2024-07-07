Class {
	#name : #JibTest,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibTest >> parseFileNamed: fileName [
	| f s j |
	f := fileName asFileReference readStream.
	s := f contents.
	f close.
	self parseString: s
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
