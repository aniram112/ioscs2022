//
//  main.swift
//  test
//
//  Created by Marina Roshchupkina on 16.03.2022.
//

import Foundation


// 1
func collapse(_ str: String) -> String{
    var cnt = 0
    var oldch: Character = "q" //str[str.startIndex]
    var res = ""
    for char in str{
        if (char == oldch){
            cnt+=1
        }
        else{
            res+=String(oldch)
            if (cnt>1){
                res+=String(cnt)
            }
            cnt = 1
        }
        
        oldch = char
    }
    res+=String(oldch)
    if (cnt>1){
        res+=String(cnt)
    }
    cnt = 1
    res.remove(at: res.startIndex)
    return res;
}

// 2
func checkPrime(_ number: Int) -> Bool{
    var flag = true
    if (number == 1 || number == 2 || number == 3 ){ return true}
    for i in 2...number/2 {
        if(number % i == 0){
            flag = false
            break;
        }
    }
    return flag
}

func numberOfPrimesLessThan(_ number: Int) -> Int{
    var num = 0
    for i in 1...number-1{
        if (checkPrime(i)){
            num+=1
        }
    }
    return num
}

// 1
//print(collapse("AB"))
//print(collapse("AABBBCRFFA") == "A2B3CRF2A")


// 2
//print(numberOfPrimesLessThan(10))
// 1 2 3 5 7

// 3
print(bestPlayers(from: info))
