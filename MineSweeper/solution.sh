#!/usr/bin/env bash

field=1

while true; do
    read n m || break

    if [[ "$n" == "0" && "$m" == "0" ]]; then
        break
    fi

    # Read grid into array
    grid=()
    for ((i=0; i<n; i++)); do
        read line
        grid[i]="$line"
    done

    # Print blank line between fields
    if (( field > 1 )); then
        echo
    fi

    echo "Field #$field:"

    # Process grid
    for ((i=0; i<n; i++)); do
        row=""
        for ((j=0; j<m; j++)); do

            cell="${grid[i]:j:1}"

            if [[ "$cell" == "*" ]]; then
                row+="*"
            else
                count=0

                for dx in -1 0 1; do
                    for dy in -1 0 1; do
                        if (( dx == 0 && dy == 0 )); then
                            continue
                        fi

                        ni=$((i + dx))
                        nj=$((j + dy))

                        if (( ni >= 0 && ni < n && nj >= 0 && nj < m )); then
                            if [[ "${grid[ni]:nj:1}" == "*" ]]; then
                                ((count++))
                            fi
                        fi
                    done
                done

                row+="$count"
            fi
        done
        echo "$row"
    done

    ((field++))
done