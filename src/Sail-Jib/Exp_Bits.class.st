Class {
	#name : #'Exp_Bits',
	#superclass : #JibExp,
	#instVars : [
		'x'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Bits class >> inducedParser [
	"
	See https://github.com/rems-project/isla/blob/master/isla-lib/src/bitvector.rs#L97
	"
	| hex bin |

	hex := (('0x' asParser / '#x' asParser) , #hex asParser plus flatten) ==> #second.

	bin := (('0b' asParser / '#b' asParser) , ($0 asParser / $1 asParser) plus flatten) ==> #second.


	^ (PPSequenceParser with:
		('bitzero' asParser ==> [ :_ | 0 toBitVector: 1 ]) /
		('bitone'  asParser ==> [ :_ | 1 toBitVector: 1 ]) /
		('emptybitvec' asParser ==> [ :_ | BitVector empty ]) /
		(hex ==>  [ :str | (Integer readFrom: str base: 16) toBitVector: str size * 4]) /
		(bin ==>  [ :str | (Integer readFrom: str base: 2) toBitVector: str size ])
	) construct: #(x)


	"
	Exp_Bits inducedParser parse:'0xAB'
	Exp_Bits inducedParser parse:'#b01'
	Exp_Bits inducedParser parse:'bitone'
	Exp_Bits inducedParser parse:'emptybitvec'
	"
]

{ #category : #enumerating }
Exp_Bits >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #'printing & storing' }
Exp_Bits >> printOn: aStream [
	x length == 0 ifTrue:[
		aStream nextPutAll: 'emptybitvec'
	] ifFalse: [
		(x length \\ 4) == 0 ifTrue:[
			aStream nextPutAll: '#x'.
			x unsignedValue printOn: aStream base: 16 length: x length // 4 padded: true.
		] ifFalse:[
			aStream nextPutAll: '#b'.
			x unsignedValue printOn: aStream base: 2 length: x length padded: true.
		]
	]
]

{ #category : #accessing }
Exp_Bits >> value [
	^ x
]
