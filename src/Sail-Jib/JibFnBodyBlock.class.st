Class {
	#name : #JibFnBodyBlock,
	#superclass : #Object,
	#instVars : [
		'body',
		'range',
		'precedessors',
		'successor1',
		'successor2'
	],
	#category : #'Sail-Jib'
}

{ #category : #utilities }
JibFnBodyBlock class >> analyze: aJibFnBody [
	"Analyze (jib) function body, create and connect basic blocks and return
    them in a collection. Entry block is guaranteed to be the first one in
    returned collection."

	| blocks curBB firstI worklist |
	
	"Pass 1: create initial set of basic blocks, cutting 
	after each goto or end instruction."	
	blocks := OrderedCollection new.
	curBB := self new.
	aJibFnBody instrs withIndexDo:[:last :lastIplus1 | 
		firstI isNil ifTrue:[
  			firstI := lastIplus1 - 1
		].		
		last isJump ifTrue:[
			| prevBB |
		
			curBB setBody: aJibFnBody range: (firstI to: lastIplus1 - 1).
			blocks add: curBB.
			prevBB := curBB.
			curBB := self new.
			prevBB setSuccessor1: curBB.
			firstI := nil.
	  ] ifFalse:[
	  (last isGoto or:[last isEnd or:[last isExit]]) ifTrue:[
			curBB setBody: aJibFnBody range: (firstI to: lastIplus1 - 1).
			blocks add: curBB.
			curBB := self new.
			firstI := nil.
		]].
	].
	firstI notNil ifTrue:[
		curBB setBody: aJibFnBody range: (firstI to: aJibFnBody instrs size - 1).
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

{ #category : #accessing }
JibFnBodyBlock >> body [
	^ body
]

{ #category : #displaying }
JibFnBodyBlock >> displayStringOn: aStream [
	aStream nextPutAll:'B '.
	self range first printOn: aStream
]

{ #category : #inspecting }
JibFnBodyBlock >> gtInstructionsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTable
		title: 'Instructions';
		display: [ self instrs ];
		column: 'Index'      evaluated: [ :insn | (self instrs indexOf: insn) - 1 + range first ];
		column: 'Instruction' evaluated: [ :insn | insn ]
]

{ #category : #accessing }
JibFnBodyBlock >> instrs [
	^body instrs copyFrom: range first + 1 to: range last + 1
]

{ #category : #utilities }
JibFnBodyBlock >> invalidate [
	self setSuccessor1: nil.
	self setSuccessor2: nil.
	body := nil.
	range := -1 to: -1.
]

{ #category : #accessing }
JibFnBodyBlock >> last [
	"Return the last instruction in this block"
	
	^body instrs at: range last + 1
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
JibFnBodyBlock >> setBody: aJibFnBody range: anInterval [
	self assert: (anInterval first between: 0 and: aJibFnBody instrs size - 1).
	self assert: (anInterval last between:  0 and: aJibFnBody instrs size - 1).
		
	body := aJibFnBody.
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

	bb1 := self class new setBody: body range: (range first to: target - 1).
	bb2 := self class new setBody: body range: (target to: range last).

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
