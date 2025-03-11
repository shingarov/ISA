Class {
	#name : #'Instr_Init',
	#superclass : #JibInstr,
	#instVars : [
		'id',
		'ty',
		'e',
		's'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Init class >> inducedParser [
	^ JibParser id
	, $: asParser trim
	, Ty asParser
	, $= asParser trim
	, JibExp asParser
	, JibSourceLoc asParser
	construct: #(id - ty - e s)

"
Instr_Init parser parse: 'zz43 = zb `6 132:2-132:8'
"
]

{ #category : #enumerating }
Instr_Init >> childrenDo: aBlock [
	aBlock value: ty.
	aBlock value: e.
	aBlock value: s 
	
]
