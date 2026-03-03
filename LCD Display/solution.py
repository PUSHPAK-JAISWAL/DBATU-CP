def lc_display():

    segments = {
        '0':[1,1,1,1,1,1,0],
        '1':[0,1,1,0,0,0,0],
        '2':[1,1,0,1,1,0,1],
        '3':[1,1,1,1,0,0,1],
        '4':[0,1,1,0,0,1,1],
        '5':[1,0,1,1,0,1,1],
        '6':[1,0,1,1,1,1,1],
        '7':[1,1,1,0,0,0,0],
        '8':[1,1,1,1,1,1,1],
        '9':[1,1,1,1,0,1,1],
    }

    while True:
        s,n = map(int,input().split())

        if s == 0 and n == 0:
            break

        n = str(n)
        rows = 2*s+3

        for r in range(rows):
            line=""
            for digit in n:
                seg = segments[digit]

                if r== 0:
                    line += " "+("-"*s if seg[0] else " "*s)+" "

                elif 1<= r <= s:
                    left = "|" if seg[5] else " "
                    right = "|" if seg[1] else " "
                    line += left +(" "*s)+right

                
                elif r == s + 1:
                    line += " "+("-"*s if seg[6] else " "*s)

                elif s + 2 <= r <= 2*s+1:
                    left = "|" if seg[4] else " "
                    right = "|" if seg[2] else " "
                    line += left + (" "*s)+right

                elif(r == 2 *s) + 2:
                    line += " "+("-"*s if seg[3] else " "*s) + " "

                line += " "

            print(line.rstrip())
            
        print()

if __name__ == "__main__":
    lc_display()