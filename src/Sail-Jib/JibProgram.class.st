Class {
	#name : #JibProgram,
	#superclass : #JibProgramNode,
	#instVars : [
		'defs',
		'sourceSearchPath',
		'sourceSubstitutePath',
		'environment'
	],
	#classVars : [
		'SourceSearchPath',
		'SourceSubstitutePath'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibProgram class >> inducedParser [
	^(PPSequenceParser with: JibDef asParser plus)
	construct: #(defs)

]

{ #category : #initalize }
JibProgram class >> initialize [
	SourceSearchPath := OrderedCollection new.
	SourceSubstitutePath := OrderedDictionary new.
]

{ #category : #accessing }
JibProgram class >> sourceSearchPath [
	^ SourceSearchPath
]

{ #category : #accessing }
JibProgram class >> sourceSubstitutePath [
	^ SourceSubstitutePath
]

{ #category : #enumerating }
JibProgram >> childrenDo: aBlock [
	defs do: aBlock
	
]

{ #category : #accessing }
JibProgram >> dataDefs [
	^defs select: #isDataDef
]

{ #category : #analysis }
JibProgram >> doSemanticAnalysis [
	"Performs analysis of a program. Once done, program's 
	 environment is valid. See class JibEnvironment.
	
	 This method is idempotent - if environment is already
	 set, we assume semantic analysys was already run and we
	 do not run it again.
	"
	| res unitSort |
	environment notNil ifTrue:[ ^ self ].
	res := [ self spriteProg solve ] runReader: #bvLengthInference initialState: BvLengthInference new.
	self assert: res isSafe.
	self setEnvironment: (JibProgramEnvironment of: self).
	self dataDefs do: [ :eachDataDef | 
		| name z3sort |
		name := eachDataDef id.
		z3sort := self environment context mkDatatypeSort: name.
		self environment registerSort: z3sort forTypename: name
	].
	unitSort := self environment context mkDatatypeSort: '__unit__'.
	self environment registerSort: unitSort forTypename: '__unit__'

]

{ #category : #enumerating }
JibProgram >> enumsDo: aBlock [
	defs do: [ :def | def isEnum ifTrue:[ aBlock value: def ] ]

]

{ #category : #accessing }
JibProgram >> environment [
	"Return program's environment. Note that environment is only
	 valid after invoking `#doSemanticAnalysis`."
	
	environment isNil ifTrue:[
		self error:'Program''s environment is not initialized. Invoke `#doSemanticAnalysis` first.'.
		^nil.
	].
	
	^ environment 
]

{ #category : #accessing }
JibProgram >> externDefs [
	^defs select: #isExtern
]

{ #category : #accessing }
JibProgram >> files [
	"Return a dictionary mapping (Sail) source file index to source file path."

	defs do:[:def |
		def isFiles ifTrue:[
			^ def dict
		]
	].
	^SmallDictionary new.

]

{ #category : #accessing }
JibProgram >> functionDefs [
	^defs select: #isFn
]

{ #category : #accessing }
JibProgram >> functionSignatures [
	^defs select: #isVal
]

{ #category : #enumerating }
JibProgram >> functionSignaturesDo: aBlock [
	defs do: [ :def | def isVal ifTrue:[ aBlock value: def ] ]
	
]

{ #category : #enumerating }
JibProgram >> functionsDo: aBlock [
	defs do: [ :def | (def isFn or:[def isExtern]) ifTrue:[ aBlock value: def ] ]
]

{ #category : #initialization }
JibProgram >> initializeFrom: values accordingTo: spec [
	super initializeFrom: values accordingTo: spec.
	sourceSearchPath := SourceSearchPath copy.
	sourceSubstitutePath := SourceSubstitutePath copy.
]

{ #category : #enumerating }
JibProgram >> letsDo: aBlock [
	defs do: [ :def | def isLet ifTrue:[ aBlock value: def ] ]

]

{ #category : #lookup }
JibProgram >> lookupFile: fileIndex [
	"Return a FileReference to (Sail) source file identified by given file index.

	 This method attempts to resolve the path according to sourceSearchPath and
	 sourceSubstitutePath. If if cannot be resolved, returns a FileReference as
	 it is in 'files' definition. Therefore, if #exists on returned value returns
	 `false` it means the source file could not be located (source is unavailable).
	 "

	| filePath file |

	filePath := self files at: fileIndex.
	file := filePath asFileReference.
	file exists ifTrue:[ ^ file ].

	"Try to resolve path along sourceSearchPath"
	sourceSearchPath do:[:dir |
		file := dir asFileReference / filePath.
		file exists ifTrue:[ ^ file ].
	].

	"No luck, return file as it is."
	^ filePath asFileReference


]

{ #category : #lookup }
JibProgram >> lookupFunction: id [
	self functionsDo: [ :fn | fn id = id ifTrue:[ ^fn ] ].
	self error:'No ''fn'' named ''' , id , ''''.
]

{ #category : #lookup }
JibProgram >> lookupFunctionSignature: id [
	self functionSignaturesDo: [ :fn | fn id = id ifTrue:[ ^fn ] ].
	self error:'No ''val'' named ''' , id , ''''.

]

{ #category : #lookup }
JibProgram >> lookupUnion: id [
	self unionDefs do: [ :def | def id = id ifTrue:[ ^def ] ].
	self error:'No ''union'' named ''' , id , ''''.
]

{ #category : #accessing }
JibProgram >> program [
	^ self
]

{ #category : #enumerating }
JibProgram >> registersDo: aBlock [
	defs do: [ :def | def isRegister ifTrue:[ aBlock value: def ] ]

]

{ #category : #initialization }
JibProgram >> setEnvironment: aJibEnvironment [
	"Sets the program's environment. This is only to be called during
	 semantic analysis to set top-level environment for the program."

	self assert: environment isNil description: 'Trying to set environment twice.'.
	
	environment := aJibEnvironment
]

{ #category : #accessing }
JibProgram >> sourceSearchPath [
	^ sourceSearchPath
]

{ #category : #accessing }
JibProgram >> sourceSubstitutePath [
	^ sourceSubstitutePath
]

{ #category : #semantics }
JibProgram >> spriteExpr [
	^(self externDefs, self functionDefs) reversed
		inject: (ΛExpression int: 0)
		into: [ :soFar :thisTime |
			ELet
				decl: thisTime spriteDecl
				expr: soFar
		]
]

{ #category : #semantics }
JibProgram >> spritePrelude [
	| unit |

	unit := Data
		name: '__unit__'
		vars: #()
		rvars: #()
		ctors: { (Ctor bind: (SpriteBind id: '__unit__') funArgs: {} reft: nil) mkCtor: '__unit__' tvs: {} rvs: {} }
		inv: Reft new known.

	^Prog
				quals: {  }
				meas: {  }
				expr: (ΛExpression int: 0)
				data: { unit }
				options: {  }
]

{ #category : #semantics }
JibProgram >> spriteProg [
	| prelude data |

	prelude := self spritePrelude.

	data := self dataDefs collect: #spriteData.
	^Prog
				quals: {  }
				meas: {  }
				expr: self spriteExpr
				data: prelude data , data
				options: {  }
]

{ #category : #accessing }
JibProgram >> unionDefs [
	^defs select: #isUnion
]

{ #category : #printing }
JibProgram >> unparseOn: aStream [
	super unparseOn: aStream.
	"
	aStream 
		nextPutAll:'...';
		nextPutAll:'...'.
	"

]
