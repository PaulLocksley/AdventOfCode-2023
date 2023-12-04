//
//  main.swift
//  AOC-2023
//
//  Created by paul locksley on 4/12/2023.
//

import Foundation

print("Hello, World!")
var base = "/Projects/AOC-2023/"
var furl = "\(base)in.txt"
furl = "\(base)in-real.txt"
var p = try String(contentsOfFile: furl,encoding: .ascii)
var o = p.split(separator: "\n")
var fullScore = o.count
var extraGames:[Int:Int] = [:];
for l in 0..<fullScore{
    extraGames[l] = 0
}
var onGame = 0;
for l in o {
    var ll = l.split(separator: ":")[1].split(separator: "|")
    var numbers = ll[0].split(separator:" ")
    var correct = ll[1].split(separator: " ")
    var gameScore = 0
    for i in numbers{
        if correct.contains(i){
            gameScore += 1
        }
    }
    print("\(l.split(separator: ":")[0]) , score: \(gameScore)")
    for _ in 0..<extraGames[onGame]!+1 {
        for i in 1..<gameScore+1{
            if i+onGame >= o.count { break }
            extraGames[onGame+i]! += 1
        }
    }
    print("\(l.split(separator: ":")[0]) , extra game count: \(extraGames[onGame]!)")
    fullScore += extraGames[onGame]!
    onGame+=1
}
print(fullScore)
print(p)

