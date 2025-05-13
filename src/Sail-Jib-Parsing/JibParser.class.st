Class {
	#name : #JibParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'exp',
		'id',
		'exp_field',
		'exp_kind',
		'exp_struct',
		'exp_unwrap',
		'exp_id',
		'exp_unwrap_in_field',
		'exp_field_in_kind',
		'exp_field_in_unwrap',
		'exp_bits',
		'exp_bool',
		'exp_call',
		'exp_i128',
		'exp_i64',
		'exp_string',
		'exp_unit',
		'exp_field_in_unwrap_in_field',
		'exp_ref'
	],
	#category : #'Sail-Jib-Parsing'
}

{ #category : #accessing }
JibParser class >> id [
	^((#letter asParser / $_ asParser), (#word asParser / $_ asParser) star) flatten
]

{ #category : #'rules - exp' }
JibParser >> exp [
	^ exp_field_in_unwrap_in_field
	/ exp_field_in_unwrap
	/ exp_field_in_kind
	/ exp_field
	/ exp_kind
	/ exp_unwrap_in_field
	/ exp_unwrap
	/ exp_struct
	""
	/ exp_bits
	/ exp_bool
	/ exp_call
	/ exp_i128
	/ exp_i64	
	/ exp_string	
	/ exp_unit
	""
	/ exp_ref
	/ exp_id
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_bits [
	| hex bin |

	hex := (('0x' asParser / '#x' asParser) , #hex asParser plus flatten) ==> #second.

	bin := (('0b' asParser / '#b' asParser) , ($0 asParser / $1 asParser) plus flatten) ==> #second.


	^ ('bitzero' asParser ==> [ :_ | 0 toBitVector: 1 ])
	/	('bitone'  asParser ==> [ :_ | 1 toBitVector: 1 ]) 
	/	('emptybitvec' asParser ==> [ :_ | BitVector empty ]) 
	/	(hex ==>  [ :str | (Integer readFrom: str base: 16) toBitVector: str size * 4]) 
	/	(bin ==>  [ :str | (Integer readFrom: str base: 2) toBitVector: str size ])
		==> [:x| Exp_Bits constructNewFrom: { x } accordingTo: #(x) ]
	
]

{ #category : #'rules - exp' }
JibParser >> exp_bool [
	^ ('true'  asParser ==> [ :_ | Bool true ])
	/ ('false'  asParser ==> [ :_ | Bool false ]) 
		==> [:x| Exp_Bool constructNewFrom: { x } accordingTo: #(b) ]
	
]

{ #category : #'rules - exp' }
JibParser >> exp_call [
	^ JibOp asParser , exp commaList
		==> [ :x | Exp_Call constructNewFrom: x accordingTo: #(op args) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_field [
	^ (exp_struct / exp_id) , $. asParser , id 
		==> [ :x | Exp_Field constructNewFrom: x accordingTo: #(exp - id) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_field_in_kind [
	"Synthetic, to avoid left recursion in grammar"

	^ exp_field , 'is' asParser trim, id 
		==> [ :x | Exp_Kind constructNewFrom: x accordingTo: #(exp - id) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_field_in_unwrap [
	^ exp_field , 'as' asParser trim, id 
		==> [ :x | Exp_Unwrap constructNewFrom: x accordingTo: #(exp - id) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_field_in_unwrap_in_field [
	^ (exp_field_in_unwrap) , $. asParser , id 
		==> [ :x | Exp_Field constructNewFrom: x accordingTo: #(exp - id) ]	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_i128 [
	^ PPParser decimalInteger , $: asParser trim , 'i128' asParser trim
		==> [:v| Exp_I128 constructNewFrom: { v } accordingTo: #(v - -) ]
	
]

{ #category : #'rules - exp' }
JibParser >> exp_i64 [
	^ PPParser decimalInteger , ($: asParser trim , 'i64' asParser trim) optional
		==> [:v| Exp_I64 constructNewFrom: v accordingTo: #(v -) ]
	
]

{ #category : #'rules - exp' }
JibParser >> exp_id [
	^ JibParser id ==> [ :x | Exp_Id constructNewFrom: { x } accordingTo: #(id) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_kind [
	^ (exp_struct / exp_id) , 'is' asParser trim, id 
		==> [ :x | Exp_Kind constructNewFrom: x accordingTo: #(exp - id) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_ref [
	^ '&' asParser trim, JibParser id ==> [ :x | Exp_Ref constructNewFrom: x accordingTo: #(- id) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_string [
	^ PPParser doubleQuoted 
		==> [:x| Exp_String constructNewFrom: { x } accordingTo: #(s) ]
	
]

{ #category : #'rules - exp' }
JibParser >> exp_struct [
	| fexp |
	
	fexp := (id , $= asParser trim , exp asParser)
					==> [ :x | x first -> x third ].

	^ 'struct' asParser trim , id trim , fexp commaSeparated braces
		==> [ :x | Exp_Struct constructNewFrom: x accordingTo: #(- id fields) ]
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_unit [
	^ '()' asParser 
		==> [ :_ | Exp_Unit new ]
	
]

{ #category : #'rules - exp' }
JibParser >> exp_unwrap [
	^ (exp_struct / exp_id) , 'as' asParser trim, id 
		==> [ :x | Exp_Unwrap constructNewFrom: x accordingTo: #(exp - id) ]
	
	
	
]

{ #category : #'rules - exp' }
JibParser >> exp_unwrap_in_field [
	"Synthetic, to avoid left recursion in grammar"
	
	^ (exp_unwrap) , $. asParser , id 
		==> [ :x | Exp_Field constructNewFrom: x accordingTo: #(exp - id) ]
	
	
	
]

{ #category : #'rules - helpers' }
JibParser >> id [
	^ self class id
]

{ #category : #accessing }
JibParser >> start [
	^ JibProgram asParser end
]
