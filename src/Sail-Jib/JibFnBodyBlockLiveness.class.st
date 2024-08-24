Class {
	#name : #JibFnBodyBlockLiveness,
	#superclass : #Object,
	#instVars : [
		'block',
		'genSet',
		'killSet',
		'liveIn',
		'liveOut'
	],
	#category : #'Sail-Jib'
}

{ #category : #utilities }
JibFnBodyBlockLiveness class >> compute: aJibFnBody [ 
	"Compute liveness of loc_ids for each block in functions' CFG. Once 
	 finished, liveness information for a block can be retrieved using `#liveness`.

	 See https://engineering.purdue.edu/~milind/ece573/2015fall/project/step7/step7.html
	 "


	"First, initialize parameter and automatic liveness info and
	 compute gen set and kill set for each block..."

	| worklist |

	aJibFnBody blocks do: [ :block |
		| liveness |

		liveness := JibFnBodyBlockLiveness forBlock: block.
		block instrsDo: [ :insn |
			insn usedIdsDo: [ :id |
				(liveness killSet includes: id) ifFalse:[
					liveness genSet add: id 
				]
			].
			insn defdIdsDo: [ :id |	liveness killSet add: id ].			
		].	
	].

	"Then, compile live-in and live-out sets for each block.

	 From https://engineering.purdue.edu/~milind/ece573/2015fall/project/step7/step7.html

	 >   The trick to computing liveness (and we will discuss this in more detail in class) is to
	 >   compute a ﬁxpoint: assignments to each of the live-in and live-out sets so that if you
	 >   try to compute any node's live-in or live-out set again, you'll get the same result you
	 >   already have. To do this, we will use a worklist algorithm:
	 >
	 >       1. Put all of the IR nodes on the worklist
	 >       2. Pull an IR node off the worklist, and compute its live-out and live-in sets
	 >       according to the deﬁnitions above.
	 >       3. If the live-in set of the node gets updated by the previous step, put all of the
	 >       node's predecessors on the worklist (because they may need to update their
	 >       live-out sets).
	 >       4. Repeat steps 2 and 3 until the worklist is empty.
	 >       5. The live-out sets of each node now represent a ﬁxpoint.
	 >
	"

	worklist := aJibFnBody blocks copy.
	[ worklist notEmpty ] whileTrue: [
		| block unused liveOut liveIn |

		block := worklist removeFirst.

		"
		>  * The set of variables that are live out of a node is the union of all the variables
		>    that are live in to the node's successors.
		"
		liveOut := Set new.
		block successorsDo: [ :succ | liveOut addAll: succ liveness liveIn ].
		"
		>   * The set of variables that are live in to a node is the set of variables that are live
		>     out for the node, minus any variables that are killed by the node, plus any
		>     variables that are gen-ed by the node.
		"
		liveIn := (liveOut difference: block liveness killSet) union: block liveness genSet.
		(liveIn ~= block liveness liveIn) ifTrue: [
			"live-in set has changed..."
			worklist addAll: block precedessors.
		].
		block liveness liveIn: liveIn.		
		block liveness liveOut: liveOut.
	].
]

{ #category : #'instance creation' }
JibFnBodyBlockLiveness class >> forBlock: aJibFnBodyBlock [
	^ self basicNew initializeWithBlock: aJibFnBodyBlock
]

{ #category : #'instance creation' }
JibFnBodyBlockLiveness class >> new [
	self shouldNotImplement. "Use #forBlock:"
]

{ #category : #accessing }
JibFnBodyBlockLiveness >> block [
	^ block
]

{ #category : #accessing }
JibFnBodyBlockLiveness >> genSet [
	^ genSet
]

{ #category : #initialization }
JibFnBodyBlockLiveness >> initializeWithBlock: aJibFnBodyBlock [ 
	block := aJibFnBodyBlock.
	genSet := Set new: 5.
	killSet := Set new: 5.
	liveIn := Set new: 0.
	liveOut := Set new: 0.

	block liveness: self.
]

{ #category : #accessing }
JibFnBodyBlockLiveness >> killSet [
	^ killSet
]

{ #category : #accessing }
JibFnBodyBlockLiveness >> liveIn [
	^ liveIn
]

{ #category : #accessing }
JibFnBodyBlockLiveness >> liveIn: aSet [
	liveIn := aSet.
]

{ #category : #accessing }
JibFnBodyBlockLiveness >> liveOut [
	^ liveOut
]

{ #category : #accessing }
JibFnBodyBlockLiveness >> liveOut: aSet [
	liveOut := aSet.
]

{ #category : #'printing & storing' }
JibFnBodyBlockLiveness >> printOn:aStream [
	"append a printed representation of the receiver to the argument, aStream"

	super printOn:aStream.
	aStream nextPutAll:'(live-in = {'.
	liveIn do:[:id | aStream nextPutAll: id ] separatedBy: [ aStream nextPut:$,; space ].
	aStream nextPutAll:'}, live-out = {'.
	liveOut do:[:sym | aStream nextPutAll: sym ] separatedBy: [ aStream nextPut:$,; space ].
	aStream nextPutAll:'})'.
]
