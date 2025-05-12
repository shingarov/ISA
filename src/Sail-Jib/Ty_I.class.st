Class {
	#name : #'Ty_I',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Ty_I >> sort [
	^ self environment context mkIntSort 
]
