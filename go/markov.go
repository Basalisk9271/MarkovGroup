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
    fmt.println("   Roman: " + toRoman(int(col)));
	if (col%2 == 0){
    	fmt.println("-- Hail Caesar!")
	
	}else{
		fmt.println("-- et tu Brute!")
	}
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

func markovRange(lower int64 , upper int64 ) int64 {
	return gen_markov_sequence(lower, upper, 1, 1, 1)

}

func gen_markov_sequence(lower int64 , upper int64, a int64 , b int64, c int64) int64 {
	// Base cases
	if(c > upper) return 0
    if(c < lower)
        if(c <= 2){
			return gen_markov_sequence(lower, upper, a, c, (3*a*c - b))
		}
        else{
			return gen_markov_sequence(lower, upper, a, c, (3*a*c - b))   //Top branch
            +      gen_markov_sequence(lower, upper, b, c, (3*b*c - a))  //Bottom branch
		}
            
    COUNT++;

    if(c <= 2){
		return c 
        + gen_markov_sequence(lower, upper, a, c, (3*a*c - b));  //Top branch ONLY
	}
        
    else {
		return c 
        + gen_markov_sequence(lower, upper, a, c, (3*a*c - b))   //Top branch
        + gen_markov_sequence(lower, upper, b, c, (3*b*c - a));  //Bottom branch
	}
        
}

func collapse(num int64) int64 {
	var i int64
	if(num < 10) {
		return num
	}
        
	long sum = 0;
	for i = num; i > 0; i /= 10){
		sum += (number %10);
	}
	return collapse(sum);
}

func toRoman(val int) string {

	//String output = new String();
	var output string

	while(val > 0){
		if(100 < val){
			output += "L";
			val -= 100;
		}
		else if(99 < val){
			output += "IL";
			val -= 99;
		}
		else if(50 < val){
			output += "C";
			val -= 50;
		}
		else if(49 < val){
			output += "IC";
			val -= 49;
		}
		else if(10 < val){
			output += "X";
			val -= 10;
		}
		else if(9 <= val){
			output += "IX";
			val -= 9;
		}
		else if(5 < val){
			output += "V";
			val -= 5;
		}
		else if(4 <= val){
			output += "IV";
			val -= 4;
		}
		else{
			output += "I";
			val -= 1;
		}
	}
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



