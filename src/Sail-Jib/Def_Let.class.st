Class {
	#name : #'Def_Let',
	#superclass : #JibDef,
	#instVars : [
		'ids',
		'instrs'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Let class >> inducedParser [
	"
	'let' '(' <ids:Comma<Arg>> ')' '{' <instrs:Semi<Instr>> '}' =>
        Def::Let(ids, instrs),
	"
	| arg |
	
	arg := JibParser id, $: asParser trim, Ty asParser ==> [ :x | x first -> x last ].
	
	^ 'let' asParser trim
	, (arg trim commaList ==> [ :x|x ifNil:#() ])
	, (JibInstr asParser, $; asParser trim ==> #first) star braces
	construct: #(- ids instrs)
]

{ #category : #enumerating }
Def_Let >> childrenDo: aBlock [
	ids do:[:arg | aBlock value: arg value].
	instrs do: aBlock
]

{ #category : #printing }
Def_Let >> displayStringOn: aStream [
	aStream nextPutAll: 'let '.
	ids do:[:nameAndType | aStream nextPutAll: nameAndType key zdecode ]
		  separatedBy:[aStream nextPutAll: ', ']
]

{ #category : #accessing }
Def_Let >> instrs [
	^instrs
]

{ #category : #testing }
Def_Let >> isLet [
	^ true
]

{ #category : #accessing }
Def_Let >> variables [
	^ ids
]
