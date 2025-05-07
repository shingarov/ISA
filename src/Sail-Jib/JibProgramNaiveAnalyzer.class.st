Class {
	#name : #JibProgramNaiveAnalyzer,
	#superclass : #Object,
	#category : #'Sail-Jib-Environment'
}

{ #category : #analysis }
JibProgramNaiveAnalyzer >> analyze: program [
	program analyzeUsing: self.
]

{ #category : #analysis }
JibProgramNaiveAnalyzer >> analyzeChildrenOf: node [
	node childrenDo:[:child | child analyzeUsing: self ].
]

{ #category : #'analysis - defs' }
JibProgramNaiveAnalyzer >> analyzeFn: fn [
	fn setEnvironment: (JibEnvironment of: fn)
]

{ #category : #'analysis - defs' }
JibProgramNaiveAnalyzer >> analyzeLet: let [
	let setEnvironment: (JibEnvironment of: let)
]

{ #category : #'analysis - defs' }
JibProgramNaiveAnalyzer >> analyzeProgram: program [
	program setEnvironment: (JibProgramEnvironment of: program).
	Z3ContextQuery answer: program environment context do:[
		self analyzeChildrenOf: program.
	] 
	
]

{ #category : #'analysis - defs' }
JibProgramNaiveAnalyzer >> analyzeRegister: register [
	register setEnvironment: (JibEnvironment of: register)
]
