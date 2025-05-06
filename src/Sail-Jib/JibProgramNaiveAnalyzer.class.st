Class {
	#name : #JibProgramNaiveAnalyzer,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'Sail-Jib-Environment'
}

{ #category : #analysis }
JibProgramNaiveAnalyzer >> analyze: program [
	environment := JibEnvironment of: program.
	"TBW..."
	program setEnvironment: environment 
]
