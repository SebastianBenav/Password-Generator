randDigit=""

placeholder=""

echo "Welcome to my Password Generator"

#Per CISA.gov, a strong password should be sufficiently long, namely, 16 characters.

#This 'for loop', which iterates 16 times, adds a random integer to $placeholder at every 'loop'.
#With every repeat $placeholder, which started at "", grows larger, until the loop terminates.
#Iteration 1: "5", Iteration 2: "59", Iteration 3 "591", ... Iteration 16: "5914256925512707"

for i in {1..16}; do

    randDigit=$((0 + $RANDOM % 9)) # Generate a random number to add to $placeholder 

    placeholder="$placeholder$randDigit"

done

#At this point, the 16 character password is made up of only numbers, so we'll begin 
#adding symbols and letters

numbersOnlyPassword=$placeholder

echo "This is a rough draft of our password: $numbersOnlyPassword"
echo

alphaLower=({a..z}) # making an array of lowercase letters 

alphaUpper=({A..Z}) # making an array of uppercase letters 

alphaComplete=(${alphaLower[@]} ${alphaUpper[@]}) #combining both arrays to make a complete array of 
                                                  #lowercase and uppercase letters 

# Now to make it truly random, we must:
# 1) choose a random index of the numbersOnlyPassword var. to replace with a letter
# 2) choose a random letter from the alphabet array to replace the random index we just selected
# 3) change a random amount of numbers from our numbersOnlyPassword var. to letters 

numOfLettersToAdd=$(( 1 + $RANDOM % 16 )) #This and the for loop below accomplish objective #3

echo "We will change $numOfLettersToAdd numbers to letters!"
echo

for ((i=1; i < $((numOfLettersToAdd + 1)); i++)); do

    characterIndex=$(( 1 + $RANDOM % 16 )) 
    # This random number, which we'll used to replace a random index from numbersOnlyPassword,
    # accomplishes objective #1
    
    randAlphaIndex=$(( 0 + $RANDOM % 51 ))

    replacement1=${alphaComplete[$randAlphaIndex]} 
    # Using a random number to select an index from the alphabet alphabet array will retreive
    # a random letter and accomplish objective #2

    echo "Iteration $i: Changing index $characterIndex  of our numbers only password to $replacement1"
    echo

    tempPassword="${numbersOnlyPassword:0:characterIndex}${replacement1}${numbersOnlyPassword:characterIndex+1}"

    numbersOnlyPassword=$tempPassword

done

numbersAndLetters=$tempPassword

echo $numbersAndLetters
echo

#We just replaced a random index of the numbersOnlyPassword to a random letter a random amount of times
#Now its time to do the same with symbols 

symbolArray=('!' '@' '#' '$' '%' '^' '&' '*' '(' ')' '_' '-' '+' '=' '`' '~' '[' ']' '{' '}' '?' '>' '<' ':' ';' '\' '/' '|')

numOfSymbolsToAdd=$(( 1 + $RANDOM % 16 ))

for ((i=1; i < $((numOfSymbolsToAdd + 1)); i++)); do 

    randIndex=$((1 + $RANDOM % 16))

    randSymIndex=$((1 + $RANDOM % 27))

    replacement2=${symbolArray[$randIndex]}

    echo "Iteration $i: Changing index $randIndex of our numbers and letters password to $replacement2"
    echo

    tempPassword2=${numbersAndLetters:0:randIndex}${replacement2}${numbersAndLetters:randIndex+1}

    numbersAndLetters=$tempPassword2

done

finalPassword=$tempPassword2

echo "The final password is: $finalPassword"




