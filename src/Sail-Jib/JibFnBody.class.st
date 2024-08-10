Class {
	#name : #JibFnBody,
	#superclass : #Object,
	#instVars : [
		'instrs'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibFnBody class >> inducedParser [
	^ (PPSequenceParser with: (JibInstr inducedParser, $; asParser trim ==> #first) star braces)
	construct: #(instrs)
]

{ #category : #'as yet unclassified' }
JibFnBody >> addTempsTo: aJibFnEnvironment [
	| decls |
	decls := instrs select: (□ isKindOf: Instr_Decl).
	decls do: (□ addTempDeclTo: aJibFnEnvironment)
]

{ #category : #accessing }
JibFnBody >> instrs [
	^ instrs
]

{ #category : #'as yet unclassified' }
JibFnBody >> toSpriteExprIn: aJibFnEnvironment [
	| them end |
	end := instrs last.
	(end isKindOf: Instr_End) ifFalse: [ self error ].
	
	them := instrs allButLast select: [ :ins | ins isKindOf: Instr_Copy "BOGUS, for this experiment" ] .
	^them
		foldr: [ :thisInstr :soFar | thisInstr toSpriteELetAround: soFar in: aJibFnEnvironment ]
		fromSeed: (end toSpriteExprIn: aJibFnEnvironment)
	
]
