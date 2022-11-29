import ("fmt")

package main

func main() {
	var lower int64
	var upper int64
	var count int64
	
	lower = 0
	upper = 50
	count = 0

	fmt.Println("Lower: ")
	fmt.Scan(&lower)
	
	fmt.Println("Upper: ")
	fmt.Scan(&upper)

	if lower > upper {
		var temp int64

	}

}

func markovRange(lower int64 , upper int64 ) int64 {
	return gen_markov_sequence(lower, upper, 1, 1, 1)

}

func gen_markov_sequence(lower int64 , upper int64, a int64 , b int64, c int64) int64 {
	if(c > upper) return 0;
    if(c < lower)
        if(c <= 2)
            return gen_markov_sequence(lower, upper, a, c, (3*a*c - b));
        else
            return gen_markov_sequence(lower, upper, a, c, (3*a*c - b))   //Top branch
            +      gen_markov_sequence(lower, upper, b, c, (3*b*c - a));  //Bottom branch

    COUNT++;

    if(c <= 2)
        return c 
        + gen_markov_sequence(lower, upper, a, c, (3*a*c - b));  //Top branch ONLY
    else 
        return c 
        + gen_markov_sequence(lower, upper, a, c, (3*a*c - b))   //Top branch
        + gen_markov_sequence(lower, upper, b, c, (3*b*c - a));  //Bottom branch
}

func collapse() int64 {

}

func toRoman() string {

}

/*

//%d for integers
//%f for floating-point numbers

//User input:

var lower int64
var upper int64

fmt.Println("Lower: ")
fmt.Scan(&lower)

fmt.Println("Upper: ")
fmt.Scan(&upper)
 
Print:

fmt.Println(i, "\n")


Main{}

markovRange{}

gen_markov_sequence{}

Collapse{}

toRoman{}


 */



