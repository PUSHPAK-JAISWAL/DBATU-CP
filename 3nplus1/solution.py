import sys

memo = {1:1}

def cycle_length(n):
    if n in memo:
        return memo[n]
    
    if n%2==0:
        length = 1+cycle_length(n//2)
    else:
        length = 1+cycle_length(3*n+1)


    memo[n] = length
    return length


for line in sys.stdin:
    if not line.strip():
        continue

    i,j = map(int,line.split())

    start = min(i,j)
    end = max(i,j)

    max_cycle = 0

    for num in range(start,end+1):
        max_cycle = max(max_cycle,cycle_length(num))


    print(i,j,max_cycle)