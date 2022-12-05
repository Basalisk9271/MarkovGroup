using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

//Max Number Range: 1 - 1000000000000000000

class markov
{
    static void Main(string[] args)
    {
        long lowerBound = long.Parse(args[0]);
        long upperBound = long.Parse(args[1]);
        

        if (lowerBound > upperBound) (lowerBound, upperBound) = (upperBound, lowerBound);

        long sum = 0; 
        ArrayList arr = markovRange(lowerBound, upperBound, ref sum);
        int col = (int) collapse(sum);
        long count = arr.Count;
        string roman = toRoman(col);

        Console.WriteLine("   Count : " + count);
        Console.WriteLine("     Sum : " + sum);
        Console.WriteLine("Collapse : " + col);
        Console.WriteLine("   Roman : " + roman);
        Console.WriteLine(col%2==0 ? "-- Hail Caesar!" : "-- et tu Brute!");

    }

    /*  --------------------------------------------------------------------------------
    *   Parameters: lower, upper, and sum
    *   Public helper function 
    *   Creates an ArrayList and calculates sum by utilizing generateMarkov()
    *   Sorts and returns ArrayList
    *   --------------------------------------------------------------------------------*/
    public static ArrayList markovRange(long lower, long upper, ref long sum)
    {
        ArrayList arr = new ArrayList();
        sum = generateMarkov(lower, upper, 1, 1, 1, ref arr);
        arr.Sort();

        return arr;
    }

    /*  --------------------------------------------------------------------------------
    *   Parameters: lower, upper, a, b, c, arr
    *   Called by markovRange()
    *   Recursively looks for Markov numbers
    *   Returns the sum of the Markovs as long
    *   --------------------------------------------------------------------------------*/
    private static long generateMarkov(long lower, long upper, int a, int b, int c, ref ArrayList arr)
    {
        if (c >= lower && c <= upper && !arr.Contains(c)) arr.Add(c);

        if (c > upper) return 0;
        if (c < lower)
        {
            if (c <= 2)
            {
                return generateMarkov(lower, upper, a, c, (3*a*c - b), ref arr);
            }
            else
            {
                return generateMarkov(lower, upper, a, c, (3*a*c - b), ref arr)
                     + generateMarkov(lower, upper, a, c, (3*b*c - a), ref arr);
            }
        }

        if (c <= 2)
        {
            return c + generateMarkov(lower, upper, a, c, (3*a*c - b), ref arr);
        }
        else
        {
            return c + generateMarkov(lower, upper, a, c, (3*a*c - b), ref arr)
                     + generateMarkov(lower, upper, a, c, (3*b*c - a), ref arr);
        }
    }

    /*  --------------------------------------------------------------------------------
    *   Parameters: num
    *   Called by main() and passed in sum
    *   Recusively sums until reaches a single digit number
    *   Returns a single digit value
    *   --------------------------------------------------------------------------------*/
    private static long collapse(long num)
    {
        if (num < 10) return num;

        long sum = 0;
        for (long i = num; i > 0; i /= 10)
            sum += (i % 10);
        return collapse(sum);

    }

    /*  --------------------------------------------------------------------------------
    *   Parameters: val
    *   Called by main() and passed in col
    *   Calculates and creates string of a Roman Numeral representation of col
    *   Returns Roman Numeral as string
    *   --------------------------------------------------------------------------------*/
    private static string toRoman(int val)
    {
        string output = "";

        if (val == 0) output = "N";
 
        while (val > 0)
        {
            if (9 <= val)
            {
                output += "IX";
                val -= 9;
            }
            else if (5 < val)
            {
                output += "V";
                val -= 5;
            }
            else if (4 <= val)
            {
                output += "IV";
                val -= 4;
            } else {
                output += "I";
                val -= 1;
            }
        }

        return output;
    }

    


}

