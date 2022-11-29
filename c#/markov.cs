using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

class markov
{
    static void Main(string[] args)
    {
        long lowerBound = long.Parse(args[0]);
        long upperBound = long.Parse(args[1]);
        uint count = 0;

        if (lowerBound > upperBound)
        {
            (lowerBound, upperBound) = (upperBound, lowerBound);
        }

        long sum = markovRange(ref lowerBound, ref upperBound, ref count);
        long col = collapse(sum);

        Console.WriteLine("Count : " + count);
        Console.WriteLine("Sum : " + sum);
        Console.WriteLine("Collapse : " + col);
        
        Console.WriteLine(col%2==0 ? "-- Hail Caesar!" : "-- et tu Brute!");

    }

    public static long markovRange(ref long lower, ref long upper, ref uint count)
    {
        int a, b, c;
        a = b = c = 1;
        return makeMarkov(ref lower, ref upper, ref count, a, b, c);
    }

    private static long makeMarkov(ref long lower, ref long upper, ref uint count, int a, int b, int c)
    {
        if (c > upper) return 0;
        if (c < lower)
        {
            if (c <= 2)
            {
                return makeMarkov(ref lower, ref upper, ref count, a, c, (3*a*c - b));
            }
            else
            {
                return makeMarkov(ref lower, ref upper, ref count, a, c, (3*a*c - b))
                         + makeMarkov(ref lower, ref upper, ref count, a, c, (3*b*c - a));
            }
        }
        count++;

        if (c <= 2)
        {
            return c + makeMarkov(ref lower, ref upper, ref count, a, c, (3*a*c - b));
        }
        else
        {
            return c + makeMarkov(ref lower, ref upper, ref count, a, c, (3*a*c - b))
                     + makeMarkov(ref lower, ref upper, ref count, a, c, (3*b*c - a));
        }
    }

    private static long collapse(long num)
    {
        if (num < 10) return num;

        long sum = 0;
        for (long number = num; number > 0; number /= 10)
            sum += (number % 10);
        return collapse(sum);

    }

    /*private static string toRoman(int val)
      {
         string output = "";
 
      }*/

    


}

