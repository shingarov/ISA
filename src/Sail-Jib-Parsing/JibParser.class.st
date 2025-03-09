Class {
	#name : #JibParser,
	#superclass : #PPCompositeParser,
	#category : #'Sail-Jib-Parsing'
}

{ #category : #accessing }
JibParser class >> id [
	^(#letter asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #accessing }
JibParser >> start [
	^ JibProgram asParser end
]
