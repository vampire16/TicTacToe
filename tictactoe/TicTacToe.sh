#!/bin/bash -x

echo "Welcome"

#CONSTANT VARIABLES
NOOFROW=3
NOOFCOL=3

#VARIABLES
declare -A board
letter=$((RANDOM%2))
toss=$((RANDOM%2))


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
	echo "Player1 assigned : $player1"
	echo "Player2 assigned : $player2"
}

function toss(){
	if (( $toss == 1 ))
	then
		echo "player1 won the toss"
	else
		echo "player2 won the toss"
	fi
}

function getBoard(){
   for (( row=0; row<NOOFROW; row++ ))
   do
      for (( column=0; column<NOOFCOL; column++ ))
      do
         if (( column<2 ))
         then
            printf "${board[$row,$column]} | "
         else
            printf "${board[$row,$column]}"
         fi
      done
      if (( row<2 ))
      then
         printf "\n-----------\n"
      fi
   done
}

function checkWin(){
	playerLetter=$1
	row=0
	column=0
	flag=false

	while [ $column -lt $NOOFCOL ]
	do
		if [[ ${board[$row,$column]}${board[$(($row+1)),$column]}${board[$(($row+2)),$column]} == $playerLetter$playerLetter$playerLetter ]]
		then
			flag=true
			echo "$flag"
		fi
		((column++))
	done

	row=0
	column=0

	while [ $row -lt $NOOFROW ]
	do
		if [[ ${board[$row,$column]}${board[$row,$(($column+1))]}${board[$row,$(($column+2))]} == $playerLetter$playerLetter$playerLetter ]]
		then
			flag=true
			echo "$flag"
		fi
		((row++))
	done

	row=0
	column=0

	if [[ ${board[$row,$column]}${board[$(($row+1)),$(($column+1))]}${board[$(($row+2)),$(($column+2))]} == $playerLetter$playerLetter$playerLetter ]]
	then
		flag=true
		echo "$flag"
	fi

	row=0
	column=$(($column+2))

	if [[ ${board[$row,$column]}${board[$(($row+1)),$(($column-1))]}${board[$(($row+2)),$(($column-2))]} == $playerLetter$playerLetter$playerLetter ]]
	then
		flag=true
		echo "$flag"
	fi

	echo "$flag"
}

resetBoard
assignLetter
toss
getBoard
checkWin $player1
