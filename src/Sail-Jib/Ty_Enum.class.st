Class {
	#name : #'Ty_Enum',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Enum class >> inducedParser [
	^ '%enum' asParser trim
	, JibParser id
]
