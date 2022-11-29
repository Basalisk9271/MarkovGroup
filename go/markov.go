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



