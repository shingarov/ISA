Class {
	#name : #JibDebugActionChangeDebugger,
	#superclass : #JibDebugAction,
	#instVars : [
		'debuggerClass',
		'newDebugger'
	],
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #accessing }
JibDebugActionChangeDebugger class >> actionsFor: debugger [
	<gtDebuggingAction>

	| availableDebuggerClasses |

	availableDebuggerClasses := JibDebugger allSubclasses reject:[:e| e isAbstract or: [e = debugger class ]].
	availableDebuggerClasses := availableDebuggerClasses reject:[:e|e name = #JibFromGTBDebugger].
	^availableDebuggerClasses collect: [:debuggerClass | self forDebugger: debugger class: debuggerClass ].
]

{ #category : #'instance creation' }
JibDebugActionChangeDebugger class >> forDebugger: aDebugger [
	self shouldNotImplement
]

{ #category : #'instance creation' }
JibDebugActionChangeDebugger class >> forDebugger: debugger class: debuggerClass [
	^(super forDebugger: debugger)
		debuggerClass: debuggerClass;
		icon: (Form extent: 0@0)
]

{ #category : #accessing }
JibDebugActionChangeDebugger >> debuggerClass: aClass [
	debuggerClass := aClass
]

{ #category : #accessing }
JibDebugActionChangeDebugger >> defaultLabel [
	^ debuggerClass defaultTitle
]

{ #category : #actions }
JibDebugActionChangeDebugger >> executeAction [

	 newDebugger := self debugger debug: self interruptedContext using: debuggerClass
]

{ #category : #accessing }
JibDebugActionChangeDebugger >> help [
	^ 'Switch to another perspective'
]

{ #category : #initialization }
JibDebugActionChangeDebugger >> initialize [
	super initialize.
	self needsUpdate: false
]
