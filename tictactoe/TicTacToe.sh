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
	count=1
	if [[ $playCount == $TOTALCOUNT ]]
	then
		echo "Match tie"
		exit
	fi
	printf "player turn\n"
	read -p "Enter position : " pos
	for (( i=0; i<NOOFROW; i++ ))
	do
		for (( j=0; j<NOOFROW; j++ ))
		do
			if [[ $count == $pos ]]
			then
				if [[ ${board[$i,$j]} == " " ]]
				then
					board[$i,$j]=$player
				else
					printf "invalid position" 
					playerTurn
				fi
			fi
			((count++))
		done
	done

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
	count=1
   if [[ $playCount == $TOTALCOUNT ]]
   then
      echo "Match tie"
		exit
   fi
	printf "computer turn\n"
   pos=$((RANDOM%9 + 1))
   for (( i=0; i<NOOFROW; i++ ))
   do
      for (( j=0; j<NOOFROW; j++ ))
      do
			if [[ $count == $pos ]]
			then
      		if [[ ${board[$i,$j]} == " " ]]
				then
					if [[ $(checkPlayerWin $computer) == false ]]
					then
						board[$i,$j]=$computer
					fi
				else
					printf "invalid position"
					computerTurn
				fi
			fi
			((count++))
      done
	done

   ((playCount++))
	getBoard
   if [[ $(checkWin $computer) == true ]]
   then
      printf "computer won"
		exit
   fi
   playerTurn
}

function checkPlayerWin(){
	layerLetter=$1
	flag=false
	for (( i=0; i<NOOFROW; i++ ))
	do
		if [[ ${board[$i,0]}${board[$i,1]} == $layerLetter$layerLetter && ${board[$i,2]} == " " ]]
		then
			if [[ ${board[$i,2]} == " " ]]
			then
				board[$i,2]=$layerLetter
				flag=true
				echo "$flag"
			fi
		elif [[ (${board[$i,0]}${board[$i,2]} == $layerLetter$layerLetter) && ${board[$i,1]} == " " ]]
      then
			if [[ ${board[$i,1]} == " " ]]
			then
         	board[$i,1]=$layerLetter
				flag=true
         	echo "$flag"
			fi
		elif [[ (${board[$i,1]}${board[$i,2]} == $layerLetter$layerLetter) && ${board[$i,0]} == " " ]]
      then
			if [[ ${board[$i,0]} == " " ]]
         then
         	board[$i,0]=$layerLetter
				flag=true
         	echo "$flag"
			fi
		fi
	done
	for (( j=0; j<NOOFROW; j++ ))
   do
      if [[ (${board[0,$j]}${board[1,$j]} == $layerLetter$layerLetter) && ${board[2,$j]} == " " ]]
      then
			if [[ ${board[2,$j]} == " " ]]
         then
         	board[2,$j]=$layerLetter
				flag=true
         	echo "$flag"
			fi
      elif [[ (${board[0,$j]}${board[2,$j]} == $layerLetter$layerLetter) && ${board[1,$j]} == " " ]]
      then
			if [[ ${board[1,$j]} == " " ]]
         then
         	board[1,$j]=$layerLetter
				flag=true
         	echo "$flag"
			fi
      elif [[ (${board[1,$j]}${board[2,$j]} == $layerLetter$layerLetter) && ${board[0,$j]} == " " ]]
      then
			if [[ ${board[0,$j]} == " " ]]
         then
         	board[0,$j]=$layerLetter
				flag=true
         	echo "$flag"
			fi
      fi
   done
	if [[ (${board[0,0]}${board[1,1]} == $layerLetter$layerLetter) && ${board[2,2]} == " " ]]
   then
		if [[ ${board[2,2]} == " " ]]
      then
   		board[2,2]=$layerLetter
			flag=true
      	echo "$flag"
		fi
  	elif [[ (${board[0,0]}${board[2,2]} == $layerLetter$layerLetter) && ${board[1,1]} == " " ]]
   then
		if [[ ${board[1,1]} == " " ]]
      then
     		board[1,1]=$layerLetter
			flag=true
      	echo "$flag"
		fi
   elif [[ (${board[1,1]}${board[2,2]} == $layerLetter$layerLetter) && ${board[0,0]} == " " ]]
  	then
		if [[ ${board[0,0]} == " " ]]
      then
     		board[0,0]=$layerLetter
			flag=true
      	echo "$flag"
		fi
	elif [[ (${board[0,2]}${board[1,1]} == $layerLetter$layerLetter) && ${board[2,0]} == " " ]]
   then
		if [[ ${board[2,0]} == " " ]]
      then
      	board[2,0]=$layerLetter
			flag=true
      	echo "$flag"
		fi
   elif [[ (${board[0,2]}${board[2,0]} == $layerLetter$layerLetter) && ${board[1,1]} == " " ]]
   then
		if [[ ${board[1,1]} == " " ]]
      then
      	board[1,1]=$layerLetter
			flag=true
      	echo "$flag"
		fi
   elif [[ (${board[1,1]}${board[2,0]} == $layerLetter$layerLetter) && ${board[0,2]} == " " ]]
   then
		if [[ ${board[0,2]} == " " ]]
      then
      	board[0,2]=$layerLetter
			flag=true
      	echo "$flag"
		fi
	fi
	echo "$flag"
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
