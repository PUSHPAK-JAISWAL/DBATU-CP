#!/usr/bin/env bash

while true; do
    read n
    (( n == 0 )) && break

    total=0
    expenses=()

    for ((i=0; i<n; i++)); do
        read amount

        dollars=${amount%.*}
        cents=${amount#*.}

        value=$((10#$dollars * 100 + 10#$cents))

        expenses+=("$value")
        (( total += value ))
    done

    avg=$(( total / n ))

    give=0
    take=0

    for e in "${expenses[@]}"; do
        if (( e > avg )); then
            (( give += e - avg ))
        else
            (( take += avg - e ))
        fi
    done

    (( give > take )) && result=$give || result=$take

    printf "\$%d.%02d\n" $(( result / 100 )) $(( result % 100 ))
done