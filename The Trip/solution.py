def solve():
    while True:
        n = int(input())
        if n==0:
            break

        expenses = []

        for _ in range(n):
            amount = float(input())
            expenses.append(int(round(amount*100)))

        total = sum(expenses)
        avg = total/n

        give = 0
        take = 0

        for e in expenses:
            diff = e-avg
            if diff>0:
                give+=int(diff)
            else:
                take += int(-diff)

        result = max(give,take)

        print(f"${result/100:.2f}")

solve()