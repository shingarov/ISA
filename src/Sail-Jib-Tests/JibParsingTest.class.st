Class {
	#name : #JibParsingTest,
	#superclass : #JibTest,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibParsingTest >> testParseDuopod [
	(self parseFileNamed: '/home/boris/work/REMS/duopod.ir') inspect
]
