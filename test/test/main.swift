//
//  main.swift
//  test
//
//  Created by Marina Roshchupkina on 16.03.2022.
//

import Foundation


// 1
func collapse(_ str: String) -> String{
    var cnt = 1
    var res = ""
    for i in 0..<str.count{
        let indOld = str.index(str.startIndex, offsetBy: i)
        let indNew = str.index(str.startIndex, offsetBy: i+1)
        if (i != str.count-1 && str[indOld] == str[indNew]){
            cnt+=1
        }else{
            res += String(str[indOld])
            if (cnt>1){res+=String(cnt)}
            cnt = 1
        }
        
    }
    return res;
}

// 2
func checkPrime(_ number: Int) -> Bool{
    if (number == 2 || number == 3 ){ return true}
    for i in 2...number/2 {
        if(number % i == 0){
            return false;
        }
    }
    return true;
}

func numberOfPrimesLessThan(_ number: Int) -> Int{
    var num = 0
    for i in 2..<number{
        if (checkPrime(i)){
            num+=1
        }
    }
    return num
}

// 1
//print(collapse("aaaaaaaaaaaaaaaaaaaaaaaa") == "a24")
//print(collapse("qqq") == "q3")
//print(collapse("AABBBCRFFA") == "A2B3CRF2A")
//print(collapse("A") == "A")


// 2
//print(numberOfPrimesLessThan(10))
// 2 3 5 7
//print(numberOfPrimesLessThan(20))
// 2 3 5 7 11 13 17 19

// 3
print(bestPlayers(from: info))
