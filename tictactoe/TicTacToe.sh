#!/bin/bash -x

echo "Welcome"

#CONSTANT VARIABLES
NO_OF_ROW=3
NO_OF_COL=3
TOTAL_COUNT=9

#VARIABLES
declare -A board
letter=$((RANDOM%2))
toss=$((RANDOM%2))
flag="false"
flag1="false"
flag2="false"
flag3="false"
flag4="false"

function getResetBoard(){
	for (( row=0; row<$NO_OF_ROW; row++ ))
	do
		for (( column=0; column<$NO_OF_COL; column++ ))
		do
			board[$row,$column]=" "
		done
	done
}

function getAssignLetter(){
	(( $letter == 1 )) && { player="O"; computer="X"; } || { player="X"; computer="O"; }
	printf "Player assigned : $player\n"
	printf "Computer assigned : $computer\n"
}

function getBoard(){
   for (( row=0; row<$NO_OF_ROW; row++ ))
   do
      for (( column=0; column<$NO_OF_COL; column++ ))
      do
         (( column<2 )) && printf "${board[$row,$column]}|" || printf "${board[$row,$column]}"
      done
      (( row<2 )) && printf "\n-----------\n"
   done
	printf "\n"
}

function checkWin(){
	playerLetter=$1
	row=0
	column=0
	flag=false

	while [ $column -lt $NO_OF_COL ]
	do
		[[ ${board[$row,$column]}${board[$(($row+1)),$column]}${board[$(($row+2)),$column]} == $playerLetter$playerLetter$playerLetter ]] && { flag=true; echo "$flag"; return; }
		((column++))
	done

	row=0
	column=0

	while [ $row -lt $NO_OF_ROW ]
	do
		[[ ${board[$row,$column]}${board[$row,$(($column+1))]}${board[$row,$(($column+2))]} == $playerLetter$playerLetter$playerLetter ]] && { flag=true; echo "$flag"; return; }
		((row++))
	done

	row=0
	column=0

	[[ ${board[$row,$column]}${board[$(($row+1)),$(($column+1))]}${board[$(($row+2)),$(($column+2))]} == $playerLetter$playerLetter$playerLetter ]] && { flag=true; echo "$flag"; return; }

	row=0
	column=$(($column+2))

	[[ ${board[$row,$column]}${board[$(($row+1)),$(($column-1))]}${board[$(($row+2)),$(($column-2))]} == $playerLetter$playerLetter$playerLetter ]] && { flag=true; echo "$flag"; return; }
	
	echo "$flag"
}

function playerTurn(){
	count=1
	[[ $playCount == $TOTAL_COUNT ]] && { echo "Match tie"; exit; }
	printf "Player turn\n"
	read -p "Enter position : " pos
	for (( i=0; i<$NO_OF_ROW; i++ ))
	do 
		for (( j=0; j<$NO_OF_ROW; j++ ))
		do
			[[ $count == $pos ]] && { [[ ${board[$i,$j]} == " " ]] && board[$i,$j]=$player || { printf "Invalid position \n"; playerTurn; } }
			((count++))
		done
	done
	((playCount++))
	getBoard
	[[ $(checkWin $player) == true ]] && { echo "Player won"; exit; }
	computerTurn
}

function checkComputerWin(){
   computer=$1
   for (( i=0; i<$NO_OF_ROW; i++ ))
   do
      if [[ ${board[$i,0]}${board[$i,1]} == $computer$computer ]]
      then
         [[ ${board[$i,2]} == " " ]] && { board[$i,2]="$computer"; flag="true"; break; }
      elif [[ ${board[$i,0]}${board[$i,2]} == $computer$computer ]]
      then
         [[ ${board[$i,1]} == " " ]] && { board[$i,1]="$computer"; flag="true"; break; }
      elif [[ ${board[$i,1]}${board[$i,2]} == $computer$computer ]]
      then
         [[ ${board[$i,0]} == " " ]] && { board[$i,0]="$computer"; flag="true"; break; }
      elif [[ ${board[0,$i]}${board[1,$i]} == $computer$computer ]]
      then
         [[ ${board[2,$i]} == " " ]] && { board[2,$i]="$computer"; flag="true"; break; }
      elif [[ ${board[0,$i]}${board[2,$i]} == $computer$computer ]]
      then
         [[ ${board[1,$i]} == " " ]] && { board[1,$i]="$computer"; flag="true"; break; }
      elif [[ ${board[1,$i]}${board[2,$i]} == $computer$computer ]]
      then
         [[ ${board[0,$i]} == " " ]] && { board[0,$i]="$computer"; flag="true"; break; }
      elif [[ ${board[0,0]}${board[1,1]} == $computer$computer ]]
      then
         [[ ${board[2,2]} == " " ]] && { board[2,2]="$computer"; flag="true"; break; }
      elif [[ ${board[0,0]}${board[2,2]} == $computer$computer ]]
      then
         [[ ${board[1,1]} == " " ]] && { board[1,1]="$computer"; flag="true"; break; }
      elif [[ ${board[1,1]}${board[2,2]} == $computer$computer ]]
      then
         [[ ${board[0,0]} == " " ]] && { board[0,0]="$computer"; flag="true"; break; }
      elif [[ ${board[0,2]}${board[1,1]} == $computer$computer ]]
      then
         [[ ${board[2,0]} == " " ]] && { board[2,0]="$computer"; flag="true"; break; }
      elif [[ ${board[0,2]}${board[2,0]} == $computer$computer ]]
      then
         [[ ${board[1,1]} == " " ]] && { board[1,1]="$computer"; flag="true"; break; }
      elif [[ ${board[1,1]}${board[2,0]} == $computer$computer ]]
      then
         [[ ${board[0,2]} == " " ]] && { board[0,2]="$computer"; flag="true"; break; }
      fi
   done
}

function checkPlayerLoss(){
   player=$1
   for (( i=0; i<$NO_OF_ROW; i++ ))
   do
      if [[ ${board[$i,0]}${board[$i,1]} == $player$player ]]
      then
         [[ ${board[$i,2]} == " " ]] && { board[$i,2]="$computer"; flag1="true"; break; }
      elif [[ ${board[$i,0]}${board[$i,2]} == $player$player ]]
      then
         [[ ${board[$i,1]} == " " ]] && { board[$i,1]="$computer"; flag1="true"; break; }
      elif [[ ${board[$i,1]}${board[$i,2]} == $player$player ]]
      then
         [[ ${board[$i,0]} == " " ]] && { board[$i,0]="$computer"; flag1="true"; break; }
      elif [[ ${board[0,$i]}${board[1,$i]} == $player$player ]]
      then
         [[ ${board[2,$i]} == " " ]] && { board[2,$i]="$computer"; flag1="true"; break; }
      elif [[ ${board[0,$i]}${board[2,$i]} == $player$player ]]
      then
         [[ ${board[1,$i]} == " " ]] && { board[1,$i]="$computer"; flag1="true"; break; }
      elif [[ ${board[1,$i]}${board[2,$i]} == $player$player ]]
      then
         [[ ${board[0,$i]} == " " ]] && { board[0,$i]="$computer"; flag1="true"; break; }
      elif [[ ${board[0,0]}${board[1,1]} == $player$player ]]
      then
         [[ ${board[2,2]} == " " ]] && { board[2,2]="$computer"; flag1="true"; break; }
      elif [[ ${board[0,0]}${board[2,2]} == $player$player ]]
      then
         [[ ${board[1,1]} == " " ]] && { board[1,1]="$computer"; flag1="true"; break; }
      elif [[ ${board[1,1]}${board[2,2]} == $player$player ]]
      then
         [[ ${board[0,0]} == " " ]] && { board[0,0]="$computer"; flag1="true"; break; }
      elif [[ ${board[0,2]}${board[1,1]} == $player$player ]]
      then
         [[ ${board[2,0]} == " " ]] && { board[2,0]="$computer"; flag1="true"; break; }
      elif [[ ${board[0,2]}${board[2,0]} == $player$player ]]
      then
         [[ ${board[1,1]} == " " ]] && { board[1,1]="$computer"; flag1="true"; break; }
      elif [[ ${board[1,1]}${board[2,0]} == $player$player ]]
      then
         [[ ${board[0,2]} == " " ]] && { board[0,2]="$computer"; flag1="true"; break; }
      fi
      done
   }

function checkCornerAvailable(){
	if [[ ${board[0,0]} == " " ]]
	then
		board[0,0]=$computer
		flag2="true"
	elif [[ ${board[0,2]} == " " ]]
	then
		board[0,2]=$computer
		flag2="true"
	elif [[ ${board[2,0]} == " " ]]
	then
		board[2,0]=$computer
		flag2="true"
	elif [[ ${board[2,2]} == " " ]]
	then
		board[2,2]=$computer
		flag2="true"
	fi
}

function checkCenter(){
	[[ ${board[1,1]} == " " ]] && { board[1,1]=$computer; flag3="true"; }
}

function checkSides(){
	if [[ ${board[0,1]} == " " ]]
	then
		board[0,1]=$computer
		flag4="true"
	elif [[ ${board[1,0]} == " " ]]
	then
		board[1,0]=$computer
		flag4="true"
	elif [[ ${board[1,2]} == " " ]]
	then
		board[1,2]=$computer
		flag4="true"
	elif [[ ${board[2,1]} == " " ]]
	then
		board[2,1]=$computer
		flag4="true"
	fi
}


function computerTurn(){
	count=1
   [[ $playCount == $TOTAL_COUNT ]] && { echo "Match tie"; exit; }
	printf "Computer turn\n"
	checkComputerWin $computer
	if [[ $flag == "true" ]]
	then
		getBoard
		printf "Computer won\n"
		exit
	else
		checkPlayerLoss $player
		if [[ $flag1 == "false" ]]
		then
			checkCornerAvailable
			if [[ $flag2 == "false" ]]
         then
            checkCenter 
            [[ $flag3 == "false" ]] && checkSides
         fi	
      fi
   fi
   ((playCount++))
   getBoard
   [[ $(checkWin $computer) == true ]] && { printf "Computer won"; exit; }
   playerTurn
}

function toss(){
    (( $toss == 1 )) && { printf "Player won the toss\n"; playerTurn;} || { printf "Computer won the toss\n"; computerTurn; }  
}

getResetBoard
getAssignLetter
toss