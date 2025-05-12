Class {
	#name : #'Ty_I',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Ty_I >> sort [
	^ self environment context mkIntSort 
]

{ #category : #semantics }
Ty_I >> spriteRType [
	^TBase
		b: TInt instance
		r: Reft new known
]
