import java.util.HashMap;
import java.util.Scanner;

public class solution {
    static HashMap<Long,Long> memo = new HashMap<>();

    public static long cycleLength(long n) {
        if(n==1) 
            return 1;

        if(memo.containsKey(n))
            return memo.get(n);

        long length;
        if(n%2==0)
            length = 1+cycleLength(n/2);
        else
            length = 1+cycleLength(3*n+1);

        memo.put(n, length);
        return length;
    }

    public static void main(String arg[]) {
        Scanner sc = new Scanner(System.in);

        while(sc.hasNextLong()) {
            long i = sc.nextLong();
            long j = sc.nextLong();

            long start = Math.min(i, j);
            long end = Math.max(i, j);

            long maxCycle = 0;
            for(long k = start;k<=end;k++) {
                maxCycle = Math.max(maxCycle,cycleLength(k));
            }
            System.out.println(i+" "+j+" "+maxCycle);
        }
        sc.close();
    }
}