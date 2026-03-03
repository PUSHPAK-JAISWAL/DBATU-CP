
M=0
N=0
declare -a grid

idx() {
    local x=$1
    local y=$2
    echo $(( (y-1)*M + (x-1) ))
}

create() {
    M=$1
    N=$2
    grid=()
    for ((i=0;i<N*M;i++)); do
        grid[i]="O"
    done
}

clear_table() {
    for ((i=0;i<N*M;i++)); do
        grid[i]="O"
    done
}

color_pixel() {
    local x=$1
    local y=$2
    local c=$3

    if [[ $x -ge 1 && $x -le $M && $y -ge 1 && $y -le $N ]]; then
        local index=$(idx "$x" "$y")
        grid[$index]="$c"
    fi
}

vertical() {
    local x=$1 y1=$2 y2=$3 c=$4
    [[ $x -lt 1 || $x -gt $M ]] && return

    if [[ $y1 -gt $y2 ]]; then
        local tmp=$y1; y1=$y2; y2=$tmp
    fi

    for ((y=y1;y<=y2;y++)); do
        if [[ $y -ge 1 && $y -le $N ]]; then
            local index=$(idx "$x" "$y")
            grid[$index]="$c"
        fi
    done
}

horizontal() {
    local x1=$1 x2=$2 y=$3 c=$4
    [[ $y -lt 1 || $y -gt $N ]] && return

    if [[ $x1 -gt $x2 ]]; then
        local tmp=$x1; x1=$x2; x2=$tmp
    fi

    for ((x=x1;x<=x2;x++)); do
        if [[ $x -ge 1 && $x -le $M ]]; then
            local index=$(idx "$x" "$y")
            grid[$index]="$c"
        fi
    done
}

rectangle_fill() {
    local x1=$1 y1=$2 x2=$3 y2=$4 c=$5

    [[ $x1 -gt $x2 ]] && { tmp=$x1; x1=$x2; x2=$tmp; }
    [[ $y1 -gt $y2 ]] && { tmp=$y1; y1=$y2; y2=$tmp; }

    for ((y=y1;y<=y2;y++)); do
        for ((x=x1;x<=x2;x++)); do
            if [[ $x -ge 1 && $x -le $M && $y -ge 1 && $y -le $N ]]; then
                local index=$(idx "$x" "$y")
                grid[$index]="$c"
            fi
        done
    done
}

flood_fill() {
    local x=$1 y=$2 c=$3

    [[ $x -lt 1 || $x -gt $M || $y -lt 1 || $y -gt $N ]] && return

    local start=$(idx "$x" "$y")
    local old="${grid[$start]}"
    [[ "$old" == "$c" ]] && return

    
    declare -a qx
    declare -a qy
    local front=0
    local back=0

    qx[$back]=$x
    qy[$back]=$y
    ((back++))
    grid[$start]="$c"

    while [[ $front -lt $back ]]; do
        local cx=${qx[$front]}
        local cy=${qy[$front]}
        ((front++))

        for d in 0 1 2 3; do
            case $d in
                0) nx=$cx; ny=$((cy-1));;
                1) nx=$cx; ny=$((cy+1));;
                2) nx=$((cx-1)); ny=$cy;;
                3) nx=$((cx+1)); ny=$cy;;
            esac

            if [[ $nx -ge 1 && $nx -le $M && $ny -ge 1 && $ny -le $N ]]; then
                local ni=$(idx "$nx" "$ny")
                if [[ "${grid[$ni]}" == "$old" ]]; then
                    grid[$ni]="$c"
                    qx[$back]=$nx
                    qy[$back]=$ny
                    ((back++))
                fi
            fi
        done
    done
}

show() {
    local name=$1
    echo "$name"
    for ((y=1;y<=N;y++)); do
        line=""
        for ((x=1;x<=M;x++)); do
            index=$(idx "$x" "$y")
            line+="${grid[$index]}"
        done
        echo "$line"
    done
}

# Main loop
while read -r cmd args; do
    [[ -z "$cmd" ]] && continue

    case "$cmd" in
        I) set -- $args; create $1 $2 ;;
        C) clear_table ;;
        L) set -- $args; color_pixel $1 $2 $3 ;;
        V) set -- $args; vertical $1 $2 $3 $4 ;;
        H) set -- $args; horizontal $1 $2 $3 $4 ;;
        K) set -- $args; rectangle_fill $1 $2 $3 $4 $5 ;;
        F) set -- $args; flood_fill $1 $2 $3 ;;
        S) set -- $args; show $1 ;;
        X) break ;;
        *) ;; # ignore invalid
    esac
done