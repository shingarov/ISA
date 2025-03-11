Class {
	#name : #'Instr_Exit',
	#superclass : #JibInstr,
	#instVars : [
		'cause',
		'src'
	],
	#pools : [
		'JibExitCause'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
Instr_Exit class >> inducedParser [
	^ 'exit' asParser trim
	, ('match' asParser ==> [ :_ | MatchFailure ] / 'explicit' asParser ==> [ :_ | Explicit ])
	, JibSourceLoc asParser
	construct: #(- cause src)
	
"
Instr_Exit inducedParser parse: 'exit match `6 131:25-134:1'
"
	
]

{ #category : #enumerating }
Instr_Exit >> childrenDo: aBlock [
	aBlock value: src

]

{ #category : #testing }
Instr_Exit >> isExit [
	^true
]
