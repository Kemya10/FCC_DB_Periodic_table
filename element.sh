#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

ARGUMENT=$1

if [[ -z $ARGUMENT ]]
then 
	echo "Please provide an element as an argument."
else
	if [[ $ARGUMENT =~ ^[0-9]+$ ]]
	then
		ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ARGUMENT")
	else
		
		ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$ARGUMENT' OR symbol='$ARGUMENT'")
	fi
	
	if [[ -z $ELEMENT ]]
	then
		echo "I could not find that element in the database."
	else
		echo "$ELEMENT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE
		do
			echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
		done
	fi
fi