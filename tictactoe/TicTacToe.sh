#!/bin/bash -x

echo "Welcome"

#CONSTANT VARIABLES
NOOFROW=3
NOOFCOL=3
TOTALCOUNT=9

#VARIABLES
declare -A board
letter=$((RANDOM%2))
toss=$((RANDOM%2))


function resetBoard(){
	for (( row=0; row<NOOFROW; row++ ))
	do
		for (( column=0; column<NOOFCOL; column++ ))
		do
			board[$row,$column]=" "
		done
	done
}

function assignLetter(){
	if (( $letter == 1 ))
	then
		player="O"
		computer="X"
	else
		player="X"
		computer="O"
	fi
	printf "Player assigned : $player\n"
	printf "Computer assigned : $computer\n"
}

function getBoard(){
   for (( row=0; row<NOOFROW; row++ ))
   do
      for (( column=0; column<NOOFCOL; column++ ))
      do
         if (( column<2 ))
         then
            printf "${board[$row,$column]}|"
         else
            printf "${board[$row,$column]}"
         fi
      done
      if (( row<2 ))
      then
         printf "\n-----------\n"
      fi
   done
	printf "\n"
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
			return
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
			return
		fi
		((row++))
	done

	row=0
	column=0

	if [[ ${board[$row,$column]}${board[$(($row+1)),$(($column+1))]}${board[$(($row+2)),$(($column+2))]} == $playerLetter$playerLetter$playerLetter ]]
	then
		flag=true
		echo "$flag"
		return
	fi

	row=0
	column=$(($column+2))

	if [[ ${board[$row,$column]}${board[$(($row+1)),$(($column-1))]}${board[$(($row+2)),$(($column-2))]} == $playerLetter$playerLetter$playerLetter ]]
	then
		flag=true
		echo "$flag"
		return
	fi

	echo "$flag"
}

function playerTurn(){
	if [[ $playCount == $TOTALCOUNT ]]
	then
		echo "Match tie"
	fi
	printf "player turn\n"
	read -p "Enter position : " pos
	case $pos in
	1)
		if [[ ${board[0,0]} == " " ]]; then board[0,0]=$player; else printf "invalid position" playerTurn; fi
		;;
	2)
      if [[ ${board[0,1]} == " " ]]; then board[0,1]=$player; else printf "invalid position" playerTurn; fi
      ;;
	3)
      if [[ ${board[0,2]} == " " ]]; then board[0,2]=$player; else printf "invalid position" playerTurn; fi
      ;;
	4)
      if [[ ${board[1,0]} == " " ]]; then board[1,0]=$player; else printf "invalid position" playerTurn; fi
      ;;
	5)
      if [[ ${board[1,1]} == " " ]]; then board[1,1]=$player; else printf "invalid position" playerTurn; fi
      ;;
	6)
      if [[ ${board[1,2]} == " " ]]; then board[1,2]=$player; else printf "invalid position" playerTurn; fi
      ;;
	7)
      if [[ ${board[2,0]} == " " ]]; then board[2,0]=$player; else printf "invalid position" playerTurn; fi
      ;;
	8)
      if [[ ${board[2,1]} == " " ]]; then board[2,1]=$player; else printf "invalid position" playerTurn; fi
      ;;
	9)
      if [[ ${board[2,2]} == " " ]]; then board[2,2]=$player; else printf "invalid position" playerTurn; fi
      ;;
	esac

	((playCount++))
	getBoard
	if [[ $(checkWin $player) == true ]]
	then
		echo "player won"
		exit
	fi
	computerTurn
}

function computerTurn(){
   if [[ $playCount == $TOTALCOUNT ]]
   then
      echo "Match tie"
   fi
	printf "computer turn\n"
   pos=$((RANDOM%9 + 1))
   case $pos in
   1)
      if [[ ${board[0,0]} == " " ]]
		then
			board[0,0]=$computer 
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   2)
      if [[ ${board[0,1]} == " " ]]
		then
			board[0,1]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   3)
      if [[ ${board[0,2]} == " " ]]
		then
			board[0,2]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   4)
      if [[ ${board[1,0]} == " " ]]
		then
			board[1,0]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   5)
      if [[ ${board[1,1]} == " " ]]
		then
			board[1,1]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   6)
      if [[ ${board[1,2]} == " " ]]
		then
			board[1,2]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   7)
      if [[ ${board[2,0]} == " " ]]
		then
			board[2,0]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   8)
      if [[ ${board[2,1]} == " " ]]
		then
			board[2,1]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   9)
      if [[ ${board[2,2]} == " " ]]
		then
			board[2,2]=$computer
		else
			printf "invalid position"
			computerTurn
		fi
      ;;
   esac

   ((playCount++))
	getBoard
   if [[ $(checkWin $computer) == true ]]
   then
      printf "computer won"
		exit
   fi
   playerTurn
}

function toss(){
   if (( $toss == 1 ))
   then
      printf "player won the toss\n"
		playerTurn
   else
      printf "Computer won the toss\n"
		computerTurn
   fi
}

resetBoard
assignLetter
toss
