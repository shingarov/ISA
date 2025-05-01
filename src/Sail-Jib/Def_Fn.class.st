Class {
	#name : #'Def_Fn',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids',
		'instrs',
		'blocks'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, (JibParser id trim commaList ==> [ :x|x ifNil:#() ])
	, (JibInstr asParser, $; asParser trim ==> #first) star braces
	construct: #(- id ids instrs)
]

{ #category : #accessing }
Def_Fn >> argNames [
	^ ids
]

{ #category : #accessing }
Def_Fn >> blocks [
	blocks isNil ifTrue:[
		blocks := JibFnBodyBlock analyze: self.
	].
	^ blocks
]

{ #category : #enumerating }
Def_Fn >> childrenDo: aBlock [
	instrs do: aBlock
	
]

{ #category : #inspecting }
Def_Fn >> gtCFGIn: composite [
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
Def_Fn >> gtInstrsIn: composite [
	<gtInspectorPresentationOrder: 20>

	^ composite fastList
		title: 'Instructions';
		display: [ instrs ];
		format: [ :insn | insn ]
]

{ #category : #accessing }
Def_Fn >> id [
	^ id
]

{ #category : #accessing }
Def_Fn >> instrs [
	^ instrs
]

{ #category : #testing }
Def_Fn >> isFn [
	^true
]

{ #category : #printing }
Def_Fn >> printOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: id zdecode
]

{ #category : #accessing }
Def_Fn >> retName [
	^ 'return'
]

{ #category : #accessing }
Def_Fn >> signature [
	"Return this function's signature (as instance of `Def_Val`)."

	self assert: parent notNil.

	^parent lookupFunctionSignature: id



]

{ #category : #'as yet unclassified' }
Def_Fn >> toSpriteDecl [
	self blocks halt
	"| ann env |
	env := JibEnvironment new.
	ann := (self program lookupFunctionSignature: id) toSpriteAnn.
	^SpriteDecl
		bind: (SpriteBind id: id)
		expr: (EAnn
			expr: ((instrs as: JibInsnArray) toSpriteExpr: env)
			ann: ann)"
]
