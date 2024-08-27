Class {
	#name : #JibFnBody,
	#superclass : #Object,
	#instVars : [
		'instrs',
		'blocks'
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
JibFnBody >> blocks [
	blocks isNil ifTrue:[
		blocks := JibFnBodyBlock analyze: self.
	].
	^blocks
]

{ #category : #inspecting }
JibFnBody >> gtCFGIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3 title: 'CFG'; initializeCanvas: [
		| canvas blocksG edges |

		canvas := RSCanvas new.
		blocksG := RSGroup new.
		self blocks do:[:block |
			| box label node |

			label := RSLabel new text: block displayString.
			box := RSShapeFactory box
							border: (RSBorder new width: 2; color: Color black);
							cornerRadius: 5;
							color: (Color gray: 0.9);
							width: label encompassingRectangle width + 16;
							height: label encompassingRectangle height + 16.
			RSLocation new center; outer; stick: label on: box.
			node := (RSComposite new model: block; shapes: { box . label }) @ RSDraggable.

			blocksG add: node.
			canvas add: node
		].

		edges := RSEdgeBuilder arrowedLine
							attachPoint: RSBorderAttachPoint new;
							yourself.

		edges
			canvas: canvas; "moveBehind;" width: 2;
			shapes: blocksG; connectToAll: #successors.

		RSVerticalLineLayout on: blocksG.
		canvas @ RSCanvasController
	]
]

{ #category : #inspecting }
JibFnBody >> gtInstructionsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTable
		title: 'Instructions';
		display: [ instrs ];
		column: 'Index'      evaluated: [ :insn | (instrs indexOf: insn) - 1 ];
		column: 'Instruction' evaluated: [ :insn | insn ]

	
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
