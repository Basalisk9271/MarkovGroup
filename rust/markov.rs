/*
CSC 330: Organization of Programming Languages - Fall 2022
Group Project: Markov Numbers
Implemented in Rust
*/

use std::env;
use std::mem;

fn markov_range(lower: i64, upper: i64) -> (Vec<i64>, i64) {
    // PRE: Bounds of the range are passed in. 
    // POST: Returns a vector containing the Markov numbers that fall within the given range and its sum. 
    
    let mut arr: Vec<i64> = Vec::new();
    let sum: i64 = generate_markov(lower, upper, 1, 1, 1, &mut arr); 
    arr.sort();

    return (arr, sum);
}

// Recursion based around Markov tree proof.
fn generate_markov(lower: i64, upper: i64, a: i64, b: i64, c: i64, list: &mut Vec<i64>) -> i64 {
    // PRE: Called from the helper function with the range to search through already specified. 
    // POST: Recursively looks for Markov numbers that fall within range and return its sum. 

    // Add to vector if the c-value is a unique Markov number. 
    if c >= lower && c <= upper && !list.contains(&c) {
        list.push(c);
    }

    // BASE CASE
    if c > upper {
        return 0;
    }

    // Tree traversal to jump into the given range. 
    if c < lower {
        if c <= 2 {
            return generate_markov(lower, upper, a, c, 3*a*c - b, list);
        } else {
            return generate_markov(lower, upper, a, c, 3*a*c - b, list) 
            +      generate_markov(lower, upper, a, c, 3*b*c - a, list);
        }
    }

    if c <= 2 {
        // Traverse to the top/next linear node in the tree. 
        return c + generate_markov(lower, upper, a, c, 3*a*c - b, list);
    } else {
        // Traverse to the top and bottom subtrees.
        return c + generate_markov(lower, upper, a, c, 3*a*c - b, list)
                 + generate_markov(lower, upper, a, c, 3*b*c - a, list);
    }
}

// Required recursive function. 
fn collapse(number: i64) -> i64 {
    // PRE: Sum of the Markov numbers is passed in. 
    // POST: Returns the collapse by recursively summing each digit until a single-digit integer is left. 

    let mut sum: i64 = 0;
    let mut i: i64 = number;
    if number < 10 {
        return number;
    } else {
        while i != 0 {
            sum += i % 10;
            i /= 10;
        }

        return collapse(sum);
    }
}

fn to_roman(mut value: i64) -> String {
    // PRE: Collapse is passed in. 
    // POST: Outputs a Roman numeral corresponding to the collapse. 

    let mut roman: String = String::new();
    if value == 0 {
        roman = "N".to_string();
    }

    while value > 0 {
        if 9 <= value {
            roman += "IX";
            value -= 9;
        } else if 5 < value {
            roman += "V";
            value -= 5;
        } else if 4 <= value {
            roman += "IV";
            value -= 4;
        } else {
            roman += "I";
            value -= 1;
        }
    }

    return roman;
}

fn main() {
    // PRE: Command line arguments are passed in to specify lower and upper bounds. 
    // POST: Outputs count, sum, and collapse of the Markov range. 

    let args: Vec<String> = env::args().collect();
    let mut lower: i64 = args[1].parse().unwrap();
    let mut upper: i64 = args[2].parse().unwrap();

    if lower > upper {
        mem::swap(&mut lower, &mut upper);
    }

    let (markov, sum) = markov_range(lower, upper);
    let col: i64 = collapse(sum);

    println!("   Count: {}", markov.len());
    println!("     Sum: {}", sum);
    println!("Collapse: {}", collapse(sum));
    println!("   Roman: {}", to_roman(col));

    if col % 2 == 0 {
        println!("-- Hail Caesar!");
    } else {
        println!("-- et tu Brute!");
    }

}

