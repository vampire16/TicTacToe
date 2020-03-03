#!/bin/bash -x

echo "Welcome"

#CONSTANT VARIABLES
NOOFROW=3
NOOFCOL=3

#VARIABLES
declare -A board


function resetBoard(){
	for (( row=0; row<NOOFROW; row++ ))
	do
		for (( column=0; column<NOOFCOL; column++ ))
		do
			board[$row,$column]=""
		done
	done
}
resetBoard
