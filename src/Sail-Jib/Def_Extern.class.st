Class {
	#name : #'Def_Extern',
	#superclass : #'Def_Val',
	#instVars : [
		'ext'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Extern class >> inducedParser [
	^   (
	    'val' asParser trim,
	    JibParser id trim,
	    '=' asParser trim,
	    PPParser doubleQuoted trim,
	    $: asParser trim
	    , Ty asParser trim commaSeparated parens trim
	    , '->' asParser trim
	    , Ty asParser trim
	    construct: #(- id - ext - tys - ty)
	) / (
	    'abstract' asParser
	)
]

{ #category : #accessing }
Def_Extern >> extern [
	^JibExtern named: ext
]

{ #category : #testing }
Def_Extern >> isExtern [
	^true
]

{ #category : #printing }
Def_Extern >> unparseOn: aStream [
	aStream nextPutAll: 'val '.
	aStream nextPutAll: id.
	aStream nextPutAll: ' = "'.
	aStream nextPutAll: ext.
	aStream nextPutAll: '" : ('.
	tys do: [:e | e unparseOn: aStream] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ') -> '.
	ty unparseOn: aStream
]
