
segments=(
  "1111110"  
  "0110000" 
  "1101101"  
  "1111001"  
  "0110011"  
  "1011011"  
  "1011111"  
  "1110000"  
  "1111111"  
  "1111011"  
)

while read -r s n; do
  [[ "$s" == "0" && "$n" == "0" ]] && break

  rows=$((2*s + 3))
  len=${#n}

  for ((r=0; r<rows; r++)); do
    line=""

    for ((d=0; d<len; d++)); do
      digit=${n:d:1}
      seg=${segments[$digit]}

      
      if [[ $r -eq 0 ]]; then
        line+=" "
        if [[ ${seg:0:1} == "1" ]]; then
          line+="$(printf "%${s}s" | tr ' ' '-')"
        else
          line+="$(printf "%${s}s")"
        fi
        line+=" "

      
      elif [[ $r -ge 1 && $r -le $s ]]; then
        [[ ${seg:5:1} == "1" ]] && line+="|" || line+=" "
        line+="$(printf "%${s}s")"
        [[ ${seg:1:1} == "1" ]] && line+="|" || line+=" "

      
      elif [[ $r -eq $((s+1)) ]]; then
        line+=" "
        if [[ ${seg:6:1} == "1" ]]; then
          line+="$(printf "%${s}s" | tr ' ' '-')"
        else
          line+="$(printf "%${s}s")"
        fi
        line+=" "

      
      elif [[ $r -ge $((s+2)) && $r -le $((2*s+1)) ]]; then
        [[ ${seg:4:1} == "1" ]] && line+="|" || line+=" "
        line+="$(printf "%${s}s")"
        [[ ${seg:2:1} == "1" ]] && line+="|" || line+=" "

      
      elif [[ $r -eq $((2*s+2)) ]]; then
        line+=" "
        if [[ ${seg:3:1} == "1" ]]; then
          line+="$(printf "%${s}s" | tr ' ' '-')"
        else
          line+="$(printf "%${s}s")"
        fi
        line+=" "
      fi

      [[ $d -lt $((len-1)) ]] && line+=" "
    done

    echo "$line"
  done

  echo
done