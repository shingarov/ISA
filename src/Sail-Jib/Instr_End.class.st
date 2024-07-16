Class {
	#name : #'Instr_End',
	#superclass : #JibInstr,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_End class >> inducedParser [
	^ 'end' asParser
	==> self uniqueInstance
]

{ #category : #accessing }
Instr_End class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]
