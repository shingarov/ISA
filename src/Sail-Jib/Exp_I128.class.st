Class {
	#name : #'Exp_I128',
	#superclass : #'Exp_I',
	#category : #'Sail-Jib'
}

{ #category : #printing }
Exp_I128 >> unparseOn: aStream [
	v printOn: aStream.
	aStream nextPutAll:' : i128'.

]
