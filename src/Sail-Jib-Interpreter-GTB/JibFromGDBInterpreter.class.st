Class {
	#name : #JibFromGDBInterpreter,
	#superclass : #JibInterpreter,
	#instVars : [
		'gdb'
	],
	#category : #'Sail-Jib-Interpreter-GTB'
}

{ #category : #'tests - instance' }
JibFromGDBInterpreter class >> forDebugger: debugger [
	^self basicNew initializeWithDebugger: debugger.
]

{ #category : #accessing }
JibFromGDBInterpreter >> gdb [
	^gdb
]

{ #category : #initialization }
JibFromGDBInterpreter >> initializeWithDebugger: debugger [
	| args fn |

	self assert: (debugger isKindOf: GDBDebugger).

	gdb := debugger.

	"BOGUS, TOTAL CRAP, DO NOT HARDCODE STUFF LIKE THIS!"
	program := JibParser parse: (JibExamples / 'Jib' / 'fakev64.ir') contents.
	fn := program lookupFunction: 'zexecute'.
	args := #().

	super initializeWithFunction: fn arguments: args.

	self readRegisters.


]

{ #category : #private }
JibFromGDBInterpreter >> readRegisters [
	"TODO, read registers from GDB to Jib"

	| pc t0 |

	pc := gdb getRegister: 'pc'.
	t0 := gdb getRegister: 't0'.

	self setRegister: 'zPC' to: (pc toBitVector: 64).
	(self getRegister: 'zXs') at: 5 put: (t0 toBitVector: 64).
]

{ #category : #private }
JibFromGDBInterpreter >> writeRegisters [
	"TODO, read registers from GDB to Jib"

	| pc t0 |

	pc := self getRegister: 'zPC'.
	t0 :=(self getRegister: 'zXs') at: 5.

	gdb setRegister: 'pc' to: pc unsignedValue.
	gdb setRegister: 't0' to: t0 unsignedValue.
]
