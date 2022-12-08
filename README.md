# CSC 330 - Group Project - Caramel Macchiato

# Markov Numbers

## Description
Write a program in different languages (C#, Go, Ada, Lisp, Rust, Cobol) that takes an command line integer arguments for a range of numbers. Then, the program will calculate the markov numbers within the range before returning an array of sorted Markov numbers within the range, the count of markov numbers, the sum of all of the markov numbers, the collapse to a single digit of the markov numbers, and the Roman numeral/message based on the number given in the collapse. 

*DISCLAIMER: The user must remember to add their command line arguments when calling the various versions of the program. Failure to do so will break the program in a way that exits the program run*


## Conceptual Logic & Algorithm   
Due to the scale of potential inputs, we recognized that a purely iterative solution towards calculating Markov numbers would be unwise. Instead, we found a pattern in the Markov sequence, making it a prime candidate for a recursive approach. If you observe an example of a [Markov Tree](https://upload.wikimedia.org/wikipedia/commons/0/0a/MarkoffNumberTree.png), you will notice that each number has two "branches", a top and bottom.  
Assume that some Markov Triple can be represented as ```(a, b, c)```. Following the **upper** branch, ```c``` moves into ```b```'s spot and the next triple would take the form of ```(a, c, x)```, where ```x``` is some other number that satisfies the triple. Conversely, in the **lower** branch, ```b``` moves into ```a```'s spot and ```c``` moves into ```b```'s former spot, so ```(a, c, y)``` again for some other ```y``` that satisfies the triple.  
In other words, for ```(a, b, c)```, our upper and lower branches would be ```(a, c, x)``` and ```(a, c, y)```, respetively.   
In order to calculate the sum of every Markov number in the given range, the the recursive function returns the newly generated ```c``` in addition to recursive calling the upper and lower branches individually. Here is some Java reference code:  
```
return c   
+ gen_markov_sequence(lower, upper, a, c, (3*a*c - b))   //Upper
+ gen_markov_sequence(lower, upper, b, c, (3*b*c - a));  //Lower
```

#### **Accounting for Bounds**
The Markov Sequence is generated from a root number of ```1```. However, since we are retrieving data from any place in the sequence, we need to account for this. In our helper function, we call the recursive sequence generation function with initial parameters of ```1```, ```1```, and ```1```. Inside the recursive function, we have two base cases: if ```c``` (or the third number in the triple) is less than the lower bound or greater than the upper bound. If it is not in that range, then it simply continues the sequence but does not add to the sum.

#### **Base Case Exception**
The only exception to the above rules are the first two triples in the sequence: the triples ```(1, 1, 1)``` and ```(1, 1, 2)```, since the upper and lower branches result in the same outputs. We account for this with in our recursive solution, where we only call one branch (we arbitrarily chose the upper branch) in order to avoid doubling our data. 

#### **Calculating *c***
Initially, we planned to simply iterate through a range of numbers to determine a third number *c* that satisfied the Markov Triple from a given *a* and *b*. However, in research we found a paper, [**The Markov-Fibonacci Numbers** by Anitha Srinivasan](https://www.fq.math.ca/Papers1/58-5/srinivasan.pdf), which revealed a relationship between the two branches of the triples. In order to calculate the third number, we need to multiply the first two by each other, then by 3, and then subtract by the previously replaced number. In other words, the next triple in the **upper** branch would be calculated with ```(a, c, (3ac-b))```, while the next **lower** triple would be ```(b, c, (3bc-a))```.

#### **Tracking the Amount of Markov Numbers** 
We decided to keep this part simple and simply initialize a global variable. We increment inside the recursive function once the number was verified as in the valid range. 

#### **Filling Array Elements**
We initally wrote the function without an array/list/data-structure in mind, where it was designed to simply calculate the sum. These approaches vary from language to language. In some langauges, where multiple return-values and/or reference passing is heavily supported and accessible, we passed a list/array reference into the recursive function and appended elements as they were found. In others, we simply created a global instance of the list/array, like the counting variable, and appended items to that directly. 

## Recursive Collapse
We approached this function similarly to some of our solutions in the *Happy Numbers* project. Our base case is satisfied when the incoming number is a single digit, positive integer. Otherwise, we collect a sum of the individual digits of the incoming value using division and modulus by 10. We then pass this sum as the parameter for the next recursive call.   
For example, an incoming value of ```245``` would be ```2+4+5```, resulting in ```11```. Now ```11``` is the incoming value for the next recursive call. It is not a single digit number, so it fails the base case and continues to summing the digits. The next recursive call is passed with ```2```. Since ```2``` is a single digit number, the function then returns ```2``` as the final return value. 

## Authors and Acknowledgment
Ervin Pangilinan - Group Leader  
Gabe Imlay - Repository Manager  
Mcgregor Koenig  
Stefan Mykytyn  
Taha Tas  
Katie Belle Duke  


## Project status
 -- Complete -- 

## Langauges 

#### *DISCAIMER: For the purpose of the example calls, the arguments being used in the run commands are the same input that was given to us by Dr. Pounds.*
---
### C#

**Compilation:** 

To compile, run:
```
mcs markov.cs
```
To execute, run:
```
mono markov.exe 1 20
```
### Go

**Compilation:** Similar to Python, this can be achieved by running the single command below

To compile, run:
```
go run markov.go 1 20
```
--- 
### Ada

**Compilation:**  

To compile, run:
```
gnatmake markov.adb 
```
To execute, run:
```
./markov 1 20
```
--- 
### Lisp

**Compilation:** You'll need to make the file executable if it is not already by using `chmod 700 markov.lisp`. Then, run the command below to execute. 
```
./markov.lisp 1 20
```
--- 
### Rust

**Compilation:** 
```
rustc -O markov.rs
```
To execute, run:
```
./markov 1 20
```
---
### Cobol

**Compilation:** 
```
cobc -m collapse.cob
```
```
cobc -x markov.cob
```
To execute, run:
```
./markov 1 20
```


