#!/bin/bash

cycle_length() {
    local n=$1
    local count=1

    while (( n != 1 ))
    do
        if (( n % 2 == 0 ))
        then
            (( n /= 2 ))
        else
            (( n = 3 * n + 1 ))
        fi
        (( count++ ))
    done

    echo "$count"
}

# The -r flag prevents backslash escaping during input
while read -r i j
do
    # Check if variables are empty
    if [[ -z "$i" ]] || [[ -z "$j" ]]
    then
        continue
    fi

    # Using (( )) allows you to use standard <= and >= operators
    if (( i <= j ))
    then
        start=$i
        end=$j
    else
        start=$j
        end=$i
    fi

    max_cycle=0

    # Bash for-loop using C-style syntax
    for (( k=start ; k<=end ; k++ ))
    do
        length=$(cycle_length "$k")
        # Again, use (( )) for the >= comparison
        if (( length >= max_cycle ))
        then
            max_cycle=$length
        fi
    done

    echo "$i $j $max_cycle"
done