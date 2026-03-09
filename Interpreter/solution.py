import sys

def solve():
    data = sys.stdin.read().splitlines()
    if not data:
        return
    
    num_cases = int(data[0])
    idx = 2
    output = []

    for _ in range(num_cases):
        ram = [0] * 1000
        reg = [0] * 10
        
        addr = 0
        while idx < len(data) and data[idx].strip():
            ram[addr] = int(data[idx].strip())
            addr += 1
            idx += 1
        
        pc = 0
        count = 0
        
        while True:
            count += 1
            instr = ram[pc]
            cmd = instr // 100
            d = (instr // 10) % 10
            n = instr % 10
            
            pc += 1
            
            if cmd == 1:
                break
            elif cmd == 2:
                reg[d] = n
            elif cmd == 3:
                reg[d] = (reg[d] + n) % 1000
            elif cmd == 4:
                reg[d] = (reg[d] * n) % 1000
            elif cmd == 5:
                reg[d] = reg[n]
            elif cmd == 6:
                reg[d] = (reg[d] + reg[n]) % 1000
            elif cmd == 7:
                reg[d] = (reg[d] * reg[n]) % 1000
            elif cmd == 8:
                reg[d] = ram[reg[n]]
            elif cmd == 9:
                ram[reg[n]] = reg[d]
            elif cmd == 0:
                if reg[n] != 0:
                    pc = reg[d]
        
        output.append(str(count))
        idx += 1

    sys.stdout.write("\n\n".join(output) + "\n")

if __name__ == "__main__":
    solve()