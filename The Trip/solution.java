import java.util.Scanner;

public class solution {
    public static void main(String args[]) {
        Scanner sc = new Scanner(System.in);

        while(true) {
            int n = sc.nextInt();
            if(n==0) 
                break;

            long[] expenses = new long[n];
            long total = 0;

            for(int i = 0;i<n;i++) {
                double amount = sc.nextDouble();
                expenses[i] = Math.round(amount*100);
                total += expenses[i];

            }

            long avg = total /n;

            long give = 0;
            long take = 0;

            for(int i = 0;i<n;i++) {
                if(expenses[i]>avg)
                    give += expenses[i]-avg;
                else 
                    take +=avg-expenses[i];
            }

            long result = Math.max(give, take);

            System.out.printf("$%.2f\n",result/100.0);
        }
        sc.close();
    }
}
