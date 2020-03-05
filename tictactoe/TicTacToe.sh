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
flag="false"

function resetBoard(){
	for (( row=0; row<$NOOFROW; row++ ))
	do
		for (( column=0; column<$NOOFCOL; column++ ))
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
   for (( row=0; row<$NOOFROW; row++ ))
   do
      for (( column=0; column<$NOOFCOL; column++ ))
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
	for (( i=0; i<$NOOFROW; i++ ))
	do
		for (( j=0; j<$NOOFROW; j++ ))
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

function checkComputerWin(){
   computer=$1
   for (( i=0; i<$NOOFROW; i++ ))
   do
      if [[ ${board[$i,0]}${board[$i,1]} == $computer$computer ]]
      then
         if [[ ${board[$i,2]} == " " ]]
         then
            board[$i,2]="$computer"
            flag="true"
				break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[$i,0]}${board[$i,2]} == $computer$computer ]]
      then
         if [[ ${board[$i,1]} == " " ]]
         then
            board[$i,1]="$computer"
            flag="true"
				break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[$i,1]}${board[$i,2]} == $computer$computer ]]
      then
         if [[ ${board[$i,0]} == " " ]]
         then
            board[$i,0]="$computer"
            flag="true"
				break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[0,$i]}${board[1,$i]} == $computer$computer ]]
      then
         if [[ ${board[2,$i]} == " " ]]
         then
            board[2,$i]="$computer"
            flag="true"
				break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[0,$i]}${board[2,$i]} == $computer$computer ]]
      then
         if [[ ${board[1,$i]} == " " ]]
         then
            board[1,$i]="$computer"
            flag="true"
				break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[1,$i]}${board[2,$i]} == $computer$computer ]]
      then
         if [[ ${board[0,$i]} == " " ]]
         then
            board[0,$i]="$computer"
            flag="true"
				break
            #echo "$flag"
            #return
         fi
   elif [[ ${board[0,0]}${board[1,1]} == $computer$computer ]]
   then
      if [[ ${board[2,2]} == " " ]]
      then
         board[2,2]="$computer"

         flag="true"
			break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[0,0]}${board[2,2]} == $computer$computer ]]
   then
      if [[ ${board[1,1]} == " " ]]
      then
         board[1,1]="$computer"
         flag="true"
			break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[1,1]}${board[2,2]} == $computer$computer ]]
   then
      if [[ ${board[0,0]} == " " ]]
      then
         board[0,0]="$computer"
         flag="true"
			break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[0,2]}${board[1,1]} == $computer$computer ]]
   then
      if [[ ${board[2,0]} == " " ]]
      then
         board[2,0]="$computer"
         flag="true"
			break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[0,2]}${board[2,0]} == $computer$computer ]]
   then
      if [[ ${board[1,1]} == " " ]]
      then
         board[1,1]="$computer"
         flag="true"
			break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[1,1]}${board[2,0]} == $computer$computer ]]
   then
      if [[ ${board[0,2]} == " " ]]
      then
         board[0,2]="$computer"
         flag="true"
			break
         #echo "$flag"
         #return
      fi
   fi
   done
   #echo "$flag"
	#echo "$layerLetter"
}

function checkPlayerLoss(){
   player=$1
   for (( i=0; i<$NOOFROW; i++ ))
   do
      if [[ ${board[$i,0]}${board[$i,1]} == $player$player ]]
      then
         if [[ ${board[$i,2]} == " " ]]
         then
            board[$i,2]="$computer"
            flag1="true"
            break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[$i,0]}${board[$i,2]} == $player$player ]]
      then
         if [[ ${board[$i,1]} == " " ]]
         then
            board[$i,1]="$computer"
            flag1="true"
            break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[$i,1]}${board[$i,2]} == $player$player ]]
      then
         if [[ ${board[$i,0]} == " " ]]
         then
            board[$i,0]="$computer"
            flag1="true"
            break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[0,$i]}${board[1,$i]} == $player$player ]]
      then
         if [[ ${board[2,$i]} == " " ]]
         then
            board[2,$i]="$computer"
            flag1="true"
            break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[0,$i]}${board[2,$i]} == $player$player ]]
      then
         if [[ ${board[1,$i]} == " " ]]
         then
            board[1,$i]="$computer"
            flag1="true"
            break
            #echo "$flag"
            #return
         fi
      elif [[ ${board[1,$i]}${board[2,$i]} == $player$player ]]
      then
         if [[ ${board[0,$i]} == " " ]]
         then
            board[0,$i]="$computer"
            flag1="true"
            break
            #echo "$flag"
            #return
         fi
   elif [[ ${board[0,0]}${board[1,1]} == $player$player ]]
   then
      if [[ ${board[2,2]} == " " ]]
      then
         board[2,2]="$computer"
         flag1="true"
         break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[0,0]}${board[2,2]} == $player$player ]]
   then
      if [[ ${board[1,1]} == " " ]]
      then
         board[1,1]="$computer"
         flag1="true"
         break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[1,1]}${board[2,2]} == $player$player ]]
   then
      if [[ ${board[0,0]} == " " ]]
      then
         board[0,0]="$computer"
         flag1="true"
         break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[0,2]}${board[1,1]} == $player$player ]]
   then
      if [[ ${board[2,0]} == " " ]]
      then
         board[2,0]="$computer"
         flag1="true"
         break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[0,2]}${board[2,0]} == $player$player ]]
   then
      if [[ ${board[1,1]} == " " ]]
      then
         board[1,1]="$computer"
         flag1="true"
         break
         #echo "$flag"
         #return
      fi
   elif [[ ${board[1,1]}${board[2,0]} == $player$player ]]
   then
      if [[ ${board[0,2]} == " " ]]
      then
         board[0,2]="$computer"
         flag1="true"
         break
         #echo "$flag"
         #return
      fi
   fi
   done
   #echo "$flag"
   #echo "$layerLetter"
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
	if [[ ${board[1,1]} == " " ]]
	then
		board[1,1]=$computer
		flag3="true"
	fi
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
	flag="false"
	flag1="false"
	flag2="false"
	flag3="false"
	flag4="false"
	count=1
   if [[ $playCount == $TOTALCOUNT ]]
   then
      echo "Match tie"
		exit
   fi
	printf "computer turn\n"
	checkComputerWin $computer
	if [[ $flag == "true" ]]
	then
		getBoard
		printf "computer won\n"
		exit
	else
		checkPlayerLoss $player
		if [[ $flag1 == "false" ]]
		then
			checkCornerAvailable
			if [[ $flag2 == "false" ]]
			then
				checkCenter
				if [[ $flag3 == "false" ]]
				then
					checkSides
					if [[ $flag4 == "false" ]]
					then
   					pos=$((RANDOM%9 + 1))
   					for (( i=0; i<$NOOFROW; i++ ))
   					do
      					for (( j=0; j<$NOOFROW; j++ ))
      					do
								if [[ $count == $pos ]]
								then
      							if [[ ${board[$i,$j]} == " " ]]
									then
										board[$i,$j]=$computer
									else
										printf "invalid position"
										computerTurn
									fi
								fi
								((count++))
      					done
						done
					fi
				fi
			fi
		fi
	fi
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
