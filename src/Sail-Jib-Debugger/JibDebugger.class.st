Class {
	#name : #JibDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'Sail-Jib-Debugger'
}

{ #category : #'building presentations' }
JibDebugger >> installBindingsForDoItIn: aPresentation from: aContext [
]

{ #category : #'building presentations' }
JibDebugger >> methodCodeWidgetIn: composite forContext: aContext [

	^composite text
		title: 'Source';
		display: [ 'this is the source' ]
	"^ composite pharoMethod
		title: 'Source';
		format: [ aContext sourceCode ];
		smalltalkClass: [  aContext methodClass ];
		doItReceiver: [ aContext receiver ];
		doItContext: [  aContext ];
		with: [ :codePresentation | 
			self installBindingsForDoItIn: codePresentation from: aContext ]"
]

{ #category : #'building presentations' }
JibDebugger >> stackWidgetIn: composite [

	^ composite fastTable	
		title: 'Stack';
		useCache;
		display: [:aSession | self retrieveStackFrom: aSession];
		column: 'Class' 
			evaluated: [ :aContext | "self formatStackClassColumnForContext: aContext" 'ClassHere' ]
			width: 300;
		column: 'Method' 
			evaluated: [ :aContext | "self formatStackMethodColumnForContext: aContext" 'MethodHere' ];
		column: 'Other' 
			evaluated: [ :aContext | "self formatStackExtraColumnForContext: aContext" 'OtherShit' ];
		hideHeader
]
