package main

import "fmt"
import "os"
import "strconv"

var lower int
var upper int
var count int64

func main() {
	count = 0
	lower,err := (strconv.Atoi(os.Args[1])) 		//get inputs from command line
	upper,err := (strconv.Atoi(os.Args[2]))
	if ( err != nil ){  							
        fmt.Println("Your inputs are invalid")
    } else {
		if (lower > upper){
			lower, upper = upper, lower
		}
		fmt.Println()

		var sum int64 = markovRange(int64(lower), int64(upper)) 
		//must cast to int64 to take into markovRange as a parameter
		var col int64 = collapse(sum)

		fmt.Println("   Count: ",count)			
		fmt.Println("     Sum: ", sum)
		fmt.Println("Collapse: ", col)
		fmt.Println("   Roman: ", toRoman(int(col)))
		
		if (col%2 == 0){
			fmt.Println("-- Hail Caesar!")
		
		} else {
			fmt.Println("-- et tu Brute!")
		
		}
	}
	

}

func markovRange(lower int64 , upper int64 ) int64 {
	return gen_markov_sequence(lower, upper, 1, 1, 1)
}

func gen_markov_sequence(lower int64 , upper int64, a int64 , b int64, c int64) int64 {
	// Base cases 
	if(c > upper){
		return 0
	}

    if(c < lower){
        if(c <= 2){
			return gen_markov_sequence(lower, upper, a, c, (3*a*c - b))
		} else {
			return gen_markov_sequence(lower, upper, a, c, (3*a*c - b)) + gen_markov_sequence(lower, upper, b, c, (3*b*c - a))
		}
    }        
    count++

    if(c <= 2){
		return c + gen_markov_sequence(lower, upper, a, c, (3*a*c - b))  //Top branch ONLY
	} else {
		return c + gen_markov_sequence(lower, upper, a, c, (3*a*c - b)) + gen_markov_sequence(lower, upper, b, c, (3*b*c - a))
	}
}

func collapse(num int64) int64 {
	var i , sum int64
	if(num < 10) {
		return num
	}
        
	sum = 0
	for i = num; i > 0; i /= 10{
		sum += (i % 10)
	}
	return collapse(sum)
}

func toRoman(val int) string {

	//String output = new String()
	var output string
	if val == 0 {				//translating val to roman numerals 
		output = "N"	
	} else {
		for (val > 0){
			if(100 < val){
				output = output + "L"
				val -= 100
			}else if(99 < val){
				output = output + "IL"
				val -= 99
			}else if(50 < val){
				output = output + "C"
				val -= 50
			}else if(49 < val){
				output = output + "IC"
				val -= 49
			}else if(10 < val){
				output = output + "X"
				val -= 10
			}else if(9 <= val){
				output = output + "IX"
				val -= 9
			}else if(5 < val){
				output = output + "V"
				val -= 5
			}else if(4 <= val){
				output = output + "IV"
				val -= 4
			}else{
				output = output + "I"
				val -= 1
			}
		}
	}
	return output
}
