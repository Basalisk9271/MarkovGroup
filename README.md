# CSC 330 - Group Project - Caramel Macchiato

# Markov Numbers

## Description
Write a program in different languages (C#, Go, Ada, Lisp, Rust, Cobol) that takes an command line integer arguments for a range of numbers. Then, the program will calculate the markov numbers within the range before returning an array of sorted Markov numbers within the range, the count of markov numbers, the sum of all of the markov numbers, the collapse to a single digit of the markov numbers, and the Roman numeral/message based on the number given in the collapse. 

*DISCLAIMER: The user must remember to add their command line arguments when calling the various versions of the program. Failure to do so will break the program in a way that exits the program run*

## Logic and Algorithm
This is a list of the functions included in the various iterations of this program

## Recursively Calculating the Markov Sequence   
*talk about algorithm*   

### function1()
    *talk about function1()*  

### function2()
    *talk about function1()*  
### function3()
    *talk about function1()*    

## Authors and Acknowledgment
Ervin Pangilinan - Group Leader
Gabe Imlay - Repository Maintainer
Mcgregor Koenig
Stefan Mykytyn
Taha Tas
Katie Belle Duke


## Project status
 -- In Progress -- 

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
cobc -x markov.cob
```
To execute, run:
```
./markov 1 20
```


