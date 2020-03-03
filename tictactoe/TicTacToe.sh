#!/bin/bash -x

echo "Welcome"

#CONSTANT VARIABLES
NOOFROW=3
NOOFCOL=3

#VARIABLES
declare -A board
letter=$((RANDOM%2))


function resetBoard(){
	for (( row=0; row<NOOFROW; row++ ))
	do
		for (( column=0; column<NOOFCOL; column++ ))
		do
			board[$row,$column]=""
		done
	done
}

function assignLetter(){
	if (( $letter == 1 ))
	then
		player1="O"
		player2="X"
	else
		player1="X"
		player2="O"
	fi
}

resetBoard
assignLetter
