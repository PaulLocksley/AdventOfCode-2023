//
//  main.swift
//  AOC-2023
//
//  Created by paul locksley on 4/12/2023.
//

import Foundation

print("Hello, World!")
var base = "/Users/paullocksley/Documents/LocksleyDev/Projects/AOC-2023/"
var furl = "\(base)in.txt"

furl = "\(base)in-real.txt"

var p = try String(contentsOfFile: furl,encoding: .ascii)
var o = p.split(separator: "\n")

func transform(map:[(destStart:Int,sourceStart:Int,length:Int)], number: Int) -> Int{
    for m in map{
        if(number >= m.sourceStart && number < m.sourceStart + m.length){
            return m.destStart+(number-m.sourceStart)
        }
    }
    
    return number
}

var maps:[[(destStart:Int,sourceStart:Int,length:Int)]] = [[],[],[],[],[],[],[]]

let seeds = o[0].split(separator:" ")[1...].map( { Int($0)! })
var lastLabel = -1

for i in o[1...]{
    if i.contains("map"){
        lastLabel += 1
        continue
    }
    let temp = i.split(separator: " ").map( { Int($0)! })
    maps[lastLabel].append((destStart: temp[0], sourceStart: temp[1], length: temp[2]))
    
}
var minNo = Int.max
for seed in seeds{
    var i = seed
    for step in maps{
        i = transform(map:step,number: i)
    }
    minNo = min(i, minNo)
}
    
print(minNo)
