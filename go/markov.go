import ("fmt")

package main

func main() {
	var lower int64
	var upper int64
	var count int64
	
	fmt.Println("Lower: ")
	fmt.Scan(&lower)
	
	fmt.Println("Upper: ")
	fmt.Scan(&upper)

	if lower > upper {
		var temp int64
		temp := lower
		lower := upper
		upper := temp
	}
	fmt.println()

	var sum int64 = markovRange(lower, upper)
	var col int64 = collapse(sum)

	fmt.println("   Count: " + count);
    fmt.println("     Sum: " + sum);
    fmt.println("Collapse: " + col);
    fmt.println("   Roman: " + toRoman((int)(col)));
	//if col%2 == 0

    //fmt.println(col%2==0 ? "-- Hail Caesar!" : "-- et tu Brute!");
	// if col %2 0 hail caeser else
	/*
	
	  System.out.println();
        
        long sum = markovRange(LOWER_BOUND, UPPER_BOUND);
        long col = collapse(sum);

        System.out.println("   Count: " + COUNT);
        System.out.println("     Sum: " + sum);
        System.out.println("Collapse: " + col);
        System.out.println("   Roman: " + toRoman((int)(col)));
        System.out.println(col%2==0 ? "-- Hail Caesar!" : "-- et tu Brute!");
	*/

}

func markovRange(int64 lower, int64 upper){
	return gen_markov_sequence(lower, upper, 1, 1, 1)

}

func gen_markov_sequence(){

}

func collapse(){

}

func toRoman(){

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



