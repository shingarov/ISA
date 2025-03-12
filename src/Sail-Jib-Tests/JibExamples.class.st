Class {
	#name : #JibExamples,
	#superclass : #Object,
	#category : #'Sail-Jib-Tests'
}

{ #category : #navigating }
JibExamples class >> / aString [
	| root |

	root := IceRepository gitDirectoryDefiningClass: self.
	root isNil ifTrue:[
		self error:'Cannot find repository root for package ', self package name.
		^nil.
	].
	root := root / 'examples'.
	root isDirectory ifFalse:[
		self error:'No such directory: ', root pathString.
		^self.
	].

	^root / aString


	"
	(JibExamples / 'Jib' / 'return42.ir') contents
	"





]
