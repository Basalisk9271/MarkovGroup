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

	}

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



