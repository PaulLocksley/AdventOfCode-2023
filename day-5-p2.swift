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

func backTransform(map:[(destStart:Int,sourceStart:Int,length:Int)], number: Int) -> Int{
    for m in map{
        if(number >= m.destStart && number < (m.destStart + m.length)){
            return m.sourceStart+(number-m.destStart)
        }
    }
    return number
}

func isValidSeed(_ seed: Int) -> Bool{
    for seedRange in seeds{
        if(seed >= seedRange.start && seed < seedRange.start + seedRange.length){
            return true
        }
    }
    return false
}

var maps:[[(destStart:Int,sourceStart:Int,length:Int)]] = [[],[],[],[],[],[],[]]
let tempseeds = o[0].split(separator:" ")[1...].map( { Int($0)! })
var jitirator = 0
var seeds: [(start: Int, length: Int)] = []
var totalSeeds = 0
while jitirator < tempseeds.count - 1 {
    seeds.append((start: tempseeds[jitirator], length: tempseeds[jitirator+1]))
    totalSeeds += tempseeds[jitirator+1]
    jitirator += 2
}
print(totalSeeds)
print(seeds.count)
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
let queue = OperationQueue()
queue.name = "com.company.concurrent"
queue.qualityOfService = .userInitiated
queue.maxConcurrentOperationCount = 8
var found = false
var mapIndexArray = (0..<maps.count).reversed()

for potentialSeed in 0 ..< 99999999 {
    queue.addOperation {
        if(found) {return}
        var i = potentialSeed
        for j in mapIndexArray {
            i = backTransform(map:maps[j],number: i)
        }
        if(isValidSeed(i)){
            minNo = potentialSeed
            print("Found valid seed \(potentialSeed)")
            found = true
        }
    }
}
print("Done concurnet")

//var mapIndexArray = (0..<maps.count).reversed()
//for potentialSeed in 0..<99999999{
//    var i = potentialSeed
//    for j in mapIndexArray {
//        i = backTransform(map:maps[j],number: i)
//    }
//    if(isValidSeed(i)){
//        minNo = potentialSeed
//        print("Found valid seed")
//        break
//    }
//    print(potentialSeed)
//}
//print("Done")
//print(minNo)
