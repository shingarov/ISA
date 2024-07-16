Class {
	#name : #JibParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'def'
	],
	#category : #'Sail-Jib'
}

{ #category : #accessing }
JibParser class >> id [
	^(#letter asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #accessing }
JibParser >> def [
	^JibDef inducedParser
]

{ #category : #accessing }
JibParser >> start [
	^ def plus end
	==> (JibProgram fromDefs: □)
]
