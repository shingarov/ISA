Class {
	#name : #JibFnBodyBlock,
	#superclass : #Object,
	#instVars : [
		'function',
		'range',
		'precedessors',
		'successor1',
		'successor2',
		'liveness'
	],
	#category : #'Sail-Jib'
}

{ #category : #utilities }
JibFnBodyBlock class >> analyze: function [
	"Analyze (jib) function, create and connect basic blocks and return
    them in a collection. Entry block is guaranteed to be the first one in
    returned collection."

	| blocks curBB firstI worklist |
	
	"Pass 1: create initial set of basic blocks, cutting 
	after each goto or end instruction."	
	blocks := OrderedCollection new.
	curBB := self new.
	function instrs withIndexDo:[:last :lastIplus1 | 
		firstI isNil ifTrue:[
  			firstI := lastIplus1 - 1
		].		
		last isJump ifTrue:[
			| prevBB |
		
			curBB setFunction: function range: (firstI to: lastIplus1 - 1).
			blocks add: curBB.
			prevBB := curBB.
			curBB := self new.
			prevBB setSuccessor1: curBB.
			firstI := nil.
	  ] ifFalse:[
	  (last isGoto or:[last isEnd or:[last isExit]]) ifTrue:[
			curBB setFunction: function range: (firstI to: lastIplus1 - 1).
			blocks add: curBB.
			curBB := self new.
			firstI := nil.
		]].
	].
	firstI notNil ifTrue:[
		curBB setFunction: function range: (firstI to: function instrs size - 1).
		blocks add: curBB.
	]. 

	
	"Pass 2: iterate over basic blocks and connect successor2 based on
   last instructions #target. If target points in the middle of basic block, split it."

	worklist := blocks copy.

	[ worklist notEmpty ] whileTrue:[
		| bb |
		
		bb := worklist removeFirst.
		
		bb last isBranch ifTrue:[
			| target succBB |

			"Find successor block."				
			target := bb last target.
			succBB := blocks detect:[:e | e range includes: target ].
				
			"If `target` points into the middle of `succBB` we have to split
			 succBB into two."
			succBB range first < target ifTrue:[ 
				| succBBs |

				succBBs := succBB splitAt: target.
				blocks remove: succBB; addAll: succBBs.
				worklist remove: succBB ifAbsent:[]; addAll: succBBs.
				
				succBB := succBBs last.
			].
   		bb setSuccessor2: succBB.
    ].
	].

	"Job done!"
	^ blocks.    
	
	
		
	

]

{ #category : #initialization }
JibFnBodyBlock >> addPrecedessor: aJibFnBodyBlock [
    precedessors isNil ifTrue:[ 
        precedessors := Array with: aJibFnBodyBlock.
    ] ifFalse:[ 
        precedessors := precedessors copyWith: aJibFnBodyBlock
    ].          
]

{ #category : #displaying }
JibFnBodyBlock >> displayStringOn: aStream [
	aStream nextPutAll:'B '.
	self range first printOn: aStream
]

{ #category : #accessing }
JibFnBodyBlock >> function [
	^ function
]

{ #category : #inspecting }
JibFnBodyBlock >> gtInstructionsAndLivenessIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite tabulator	
			title: 'Instructions';
			with: [ :pane |
				pane row: #instructions; row: #liveness.
				pane transmit
					to: #instructions;
					andShow: [ :a | self gtInstructionsIn: a].
				pane transmit
					to: #liveness;
					andShow: [ :a | self gtLivenessIn: a].
			]
]

{ #category : #inspecting }
JibFnBodyBlock >> gtInstructionsIn: composite [
	"<gtInspectorPresentationOrder: 1>"
	^ composite fastTable
		title: 'Instructions';
		display: [ self instrs ];
		column: 'Index'      evaluated: [ :insn | (self instrs indexOf: insn) - 1 + range first ];
		column: 'Instruction' evaluated: [ :insn | insn ]
]

{ #category : #inspecting }
JibFnBodyBlock >> gtLivenessIn: composite [
	"<gtInspectorPresentationOrder: 2>"
	liveness notNil ifTrue:[
		composite text
			title: 'Liveness';
			display: [ String streamContents: [ :text |
					text nextPutAll: 'live-in:'; cr.
					liveness liveIn do:[:id|
						text nextPutAll: '    '; nextPutAll: id; cr.
					].
					text cr.
					text nextPutAll: 'live-out:'; cr.
					liveness liveOut do:[:id|
						text nextPutAll: '    '; nextPutAll: id; cr.
					].
					text cr.
					text nextPutAll: 'gen-set:'; cr.
					liveness genSet do:[:id|
						text nextPutAll: '    '; nextPutAll: id; cr.
					].
			
					text cr.
					text nextPutAll: 'kill-set:'; cr.
					liveness killSet do:[:id|
						text nextPutAll: '    '; nextPutAll: id; cr.
					].
			]]
	] ifFalse:[
		composite pharoScript
			title: 'Liveness';
			doItReceiver: self;
			display: [ String streamContents: [ :text |
					text nextPutAll: '"Liveness not yet computed. Select and evaluate:"'; cr.
					text cr.
					text nextPutAll: '    JibFnBodyBlockLiveness compute: self function'; cr.
			]]
	].


]

{ #category : #accessing }
JibFnBodyBlock >> instrs [
	^function instrs copyFrom: range first + 1 to: range last + 1
]

{ #category : #enumerating }
JibFnBodyBlock >> instrsDo: aBlock [
	range first + 1 to: range last + 1 do:[:i|
		aBlock value: (function instrs at: i)
	].
]

{ #category : #utilities }
JibFnBodyBlock >> invalidate [
	self setSuccessor1: nil.
	self setSuccessor2: nil.
	function := nil.
	range := -1 to: -1.
]

{ #category : #accessing }
JibFnBodyBlock >> last [
	"Return the last instruction in this block"
	
	^function instrs at: range last + 1
]

{ #category : #accessing }
JibFnBodyBlock >> liveness [
	^ liveness
]

{ #category : #accessing }
JibFnBodyBlock >> liveness: anObject [
	liveness := anObject
]

{ #category : #accessing }
JibFnBodyBlock >> precedessors [
	precedessors isNil ifTrue:[^#()].
	^ precedessors
]

{ #category : #printing }
JibFnBodyBlock >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut:$(.
	range first printOn: aStream.
	aStream nextPutAll:', '.
	range last printOn: aStream.
	aStream nextPut:$)
]

{ #category : #accessing }
JibFnBodyBlock >> range [
	^ range
]

{ #category : #initialization }
JibFnBodyBlock >> removePrecedessor: aJibFnBodyBlock [
	self assert:(precedessors notNil and:[precedessors includes: aJibFnBodyBlock]).

    precedessors size == 1 ifTrue:[
        precedessors := nil
    ] ifFalse:[ 
        precedessors := precedessors copyWithout: aJibFnBodyBlock
    ].          
]

{ #category : #initialization }
JibFnBodyBlock >> setFunction: aDef_Fn range: anInterval [
	self assert: (anInterval first between: 0 and: aDef_Fn instrs size - 1).
	self assert: (anInterval last between:  0 and: aDef_Fn instrs size - 1).
		
	function := aDef_Fn.
	range := anInterval.
]

{ #category : #initialization }
JibFnBodyBlock >> setSuccessor1: aJibFnBodyBlock [
	successor1 notNil ifTrue: [
		successor1 removePrecedessor: self.
	].      
	successor1 := aJibFnBodyBlock.
	successor1 notNil ifTrue: [
		successor1 addPrecedessor: self.
	].      
]

{ #category : #initialization }
JibFnBodyBlock >> setSuccessor2: aJibFnBodyBlock [
	successor2 notNil ifTrue: [
		successor2 removePrecedessor: self.
	].      
	successor2 := aJibFnBodyBlock.
	successor2 notNil ifTrue: [
		successor2 addPrecedessor: self.
	].      
]

{ #category : #utilities }
JibFnBodyBlock >> splitAt: target [
	| bb1 bb2 |

	self assert:(range includes: target).

	bb1 := self class new setFunction: function range: (range first to: target - 1).
	bb2 := self class new setFunction: function range: (target to: range last).

	bb1 setSuccessor1: bb2.
 	bb2 setSuccessor1: successor1.
  	bb2 setSuccessor2: successor2.

	(precedessors notNil and:[precedessors notEmpty]) ifTrue:[
		precedessors do:[:precedessor | 
			precedessor successor1 == self ifTrue:[ 
	  			precedessor setSuccessor1: bb1.
			].
			precedessor successor2 == self ifTrue:[ 
	  			precedessor setSuccessor2: bb1.
			].
		].
	].

	self invalidate.

	^ { bb1 . bb2 }.
]

{ #category : #semantics }
JibFnBodyBlock >> spriteArgNames [
	"Return the list of argument names of function
	 representing this basic block.
	
	 This list consist of arguments of the original Jib function
	 plus all live-in variables. 
	 Note that arguments (of the original Jib) are *always* included
	 even if they're not live-in. This is a simple little trick - 
	 Just like Jib, Sprite does not allow no-argument functions.
	 So always adding arguments ensures there's always at least 
	 one argument to (new) Sprite function.
	"


	| funcArgs |
	
	funcArgs := function argNames.	
	^ funcArgs, (liveness liveIn reject:[:v | funcArgs includes: v])
	
	
]

{ #category : #semantics }
JibFnBodyBlock >> spriteDecl [
	^SpriteDecl
		bind: (SpriteBind id: self spriteFunName)
		expr: (EAnn
			expr: self spriteEFun
			 ann: self spriteVal )
]

{ #category : #semantics }
JibFnBodyBlock >> spriteEFun [
	^self spriteArgNames reversed
		inject: self spriteExpr
		into: [ :expr :argName | EFun bind: (SpriteBind id: argName) expr: expr ]
]

{ #category : #semantics }
JibFnBodyBlock >> spriteExpr [
	| pass |

	pass := successor1 notNil 
				ifTrue:[successor1 spriteΛEApp]
				ifFalse:[ΛExpression diverge].

	^self instrs reversed
		inject: pass
		into: [ :soFar :thisTime | thisTime spriteExprContWith: soFar ]
]

{ #category : #semantics }
JibFnBodyBlock >> spriteFunName [
	^'B_' , range first printString
]

{ #category : #semantics }
JibFnBodyBlock >> spriteRType [
	| argTys retTy |
	
	self assert: liveness notNil.
	
	argTys := self spriteArgNames collect: [ :var | function varTypeOf: var ].
	retTy := function retType.

	^argTys reversed
		inject: retTy spriteRType
		into: [ :soFar :thisTime | TFun
				x: String junkSymbol
				s: thisTime spriteRType
				t: soFar ]
	
]

{ #category : #semantics }
JibFnBodyBlock >> spriteVal [
	^Val
		symbol: self spriteFunName
		rtype: self spriteRType
		metric: nil
]

{ #category : #semantics }
JibFnBodyBlock >> spriteΛEApp [
	"Return the 'call' to this block. Used to implement
	 transitions from one block to another."
	
	self assert: liveness notNil.
	
	^ ΛEApp mkEApp: (EImm imm: (EVar of: self spriteFunName)) 
	          args: (self spriteArgNames collect:[:arg |EVar of: arg])
	
	
]

{ #category : #accessing }
JibFnBodyBlock >> successor1 [
	^ successor1
]

{ #category : #accessing }
JibFnBodyBlock >> successor2 [
	^ successor2
]

{ #category : #accessing }
JibFnBodyBlock >> successors [
	successor2 isNil ifTrue:[
		successor1 isNil ifTrue:[ ^#() ].
		^ { successor1 }
	].

	successor1 isNil ifTrue:[ ^ { successor2 } ].
	^ { successor1 . successor2 }
]

{ #category : #enumerating }
JibFnBodyBlock >> successorsDo: aBlock [
	successor1 notNil ifTrue:[aBlock value: successor1].
	successor2 notNil ifTrue:[aBlock value: successor2].
]
