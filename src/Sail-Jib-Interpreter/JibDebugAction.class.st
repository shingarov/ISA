Class {
	#name : #JibDebugAction,
	#superclass : #DebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #testing }
JibDebugAction >> appliesToDebugger: aDebugger [

	^ aDebugger isKindOf: JibDebugger 
]

{ #category : #accessing }
JibDebugAction >> defaultLabel [
	^ self class name , '>>defaultLabel'
]

{ #category : #actions }
JibDebugAction >> executeAction [
	self subclassResponsibility 
	
]

{ #category : #accessing }
JibDebugAction >> help [
	^ 'Please override #help in class ', self class name
]
