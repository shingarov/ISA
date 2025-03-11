Class {
	#name : #'SourceLoc_Unknown',
	#superclass : #JibSourceLoc,
	#instVars : [
		'u'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
SourceLoc_Unknown class >> inducedParser [
	^ nil asParser ==> [ :_ | self new ]
]
