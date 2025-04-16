Class {
	#name : #JibFromGTBDebugger,
	#superclass : #JibDebugger,
	#category : #'Sail-Jib-Interpreter-GTB'
}

{ #category : #accessing }
JibFromGTBDebugger class >> sessionClass [

	^ JibFromGTBDebuggerSession
]

{ #category : #accessing }
JibFromGTBDebugger class >> spanNewSessionFrom: anotherSession [
	| interpreter |

	self assert: (anotherSession isKindOf: GTBDebuggerSession).

	interpreter := JibFromGDBInterpreter forDebugger: anotherSession debugger.
	^ JibFromGTBDebuggerSession for: interpreter.
]

{ #category : #updating }
JibFromGTBDebugger >> updateBrowser [
	| browserPane session |

	session := self session.
	session interruptedContext ifNil: [
		"Following code is copy-paste-n-hacked version of #debug:using:"

		| newSession newDebugger |

		session writeRegisters.
		self detachSession.
		self browser close.
		"session updateContextTo: aContext."
		newSession := GTBDebugger sessionClass on: session gdb.
		newDebugger := GTBDebugger on: newSession.
		^ self openAndInitialize: newDebugger
	] ifNotNil: [
		browserPane := self browser pane.
		(browserPane port: #entity) silentValue: nil.
		(browserPane port: #entity) value: session.
	]
]
