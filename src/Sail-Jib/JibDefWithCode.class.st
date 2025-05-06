Class {
	#name : #JibDefWithCode,
	#superclass : #JibDef,
	#instVars : [
		'instrs',
		'blocks'
	],
	#category : #'Sail-Jib'
}

{ #category : #accessing }
JibDefWithCode >> blocks [
	blocks isNil ifTrue:[
		blocks := JibFnBodyBlock analyze: self.
	].
	^ blocks
]

{ #category : #inspecting }
JibDefWithCode >> gtCFGIn: composite [
	<gtInspectorPresentationOrder: 50>
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
JibDefWithCode >> gtInstructionsIn: composite [
	<gtInspectorPresentationOrder: 20>

	^ composite fastTable
		title: 'Instructions';
		display: [ instrs ];
		column: 'Index'
			evaluated: [ :insn | (instrs indexOf: insn) - 1];
		column: 'Instruction'
			evaluated: [ :insn | insn unparsedString ];
		selectionAct: [ :list | list selection inspect ]
			iconName: #smallInspectIt
			entitled: 'Inspect'.
]

{ #category : #accessing }
JibDefWithCode >> instrs [
	^ instrs
]
