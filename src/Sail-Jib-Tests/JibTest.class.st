Class {
	#name : #JibTest,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibTest >> test1 [
	| f s j |
	f := '/home/boris/work/REMS/isla-snapshots/smalltalk.ir' asFileReference readStream.
	s := f contents.
	f close.

	j := JibParser new end parse: s.
self halt.
'a' zencode

]

{ #category : #tests }
JibTest >> testDuopod [
	| f s j |
	f := '/home/boris/work/REMS/duopod.ir' asFileReference readStream.
	s := f contents.
	f close.

	j := JibParser new parse: s
]
