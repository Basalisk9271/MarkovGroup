/*
CSC 330: Organization of Programming Languages - Fall 2022
Group Project: Markov Numbers
Implemented in Rust
*/

use std::env;

fn markov_range(lower: i64, upper: i64) -> (Vec<i64>, i64) {
    // PRE: Bounds of the range are passed in. 
    // POST: Returns a vector containing the Markov numbers that fall within the given range and its sum. 
    
    let mut markov: Vec<i64> = Vec::new();
    let mut sum: i64 = 0;



    return (markov, sum);
}

// Recursion based around Markov tree proof.
fn generate_markov(lower: i64, upper: i64, a: i64, b: i64, c: i64, &mut list: Vec<i64>) -> i64 {
    // PRE: Called from the helper function with the range to search through already specified. 
    // POST: Recursively looks for Markov numbers that fall within range. 

    // Add to vector if the c-value is a unique Markov number. 
    if c >= lower && c <= upper && !list.contains(c) {
        list.push(c);
    }

    // BASE CASE
    if c > upper {
        return 0;
    }

    // Tree traversal to jump into the given range. 
    if c < lower {
        if c <= 2 {
            return generate_markov(lower, upper, a, c, (3*a*c - b));
        } else {
            return generate_markov(lower, upper, a, c, (3*a*c - b)) 
            +      generate_markov(lower, upper, a, c, (3*b*c - a));
        }
    }

    if c <= 2 {
        // Traverse to the top/next linear node in the tree. 
        return c + generate_markov(lower, upper, a, c, (3*a*c - b));
    } else {
        // Traverse to the top and bottom subtrees.
        return c + generate_markov(lower, upper, a, c, (3*a*c - b))
                 + generate_markov(lower, upper, a, c, (3*b*c - a));
    }
}

// Required recursive function. 
fn collapse() -> i64 {
    // PRE: Sum of the Markov numbers is passed in. 
    // POST: Returns the collapse by recursively summing each digit until a single-digit integer is left. 


}

fn to_roman() -> String {
    // PRE: Collapse is passed in. 
    // POST: Outputs a Roman numeral corresponding to the collapse. 


}

fn main() {
    // PRE: Command line arguments are passed in to specify lower and upper bounds. 
    // POST: Outputs count, sum, and collapse of the Markov range. 

    
}

