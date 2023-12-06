//
//  main.swift
//  AOC-2023
//
//  Created by paul locksley on 4/12/2023.
//

import Foundation
class day6{
    func p1() throws{
        print("Hello, World!")
        var base = "/Users/paullocksley/Documents/LocksleyDev/Projects/AOC-2023/"
        var furl = "\(base)in.txt"
        
        furl = "\(base)in-real.txt"
        
        var p = try String(contentsOfFile: furl,encoding: .ascii)
        var o = p.split(separator: "\n")
        var o1 = o[0].split(separator: " ")
        var o2 = o[1].split(separator: " ")
        var races:[(rtime: Int, distance: Int)] = []
        for i in 1..<o1.count{
            races.append((Int(o1[i])!,Int(o2[i])!))
        }
        
        func distanceCovered(accel: Int, time: Int) -> Int {
            return accel * time
        }
        
        func countValidStats(race: (rtime: Int, distance: Int)) -> Int{
            var count = 0
            for i in 1...race.rtime{
                if distanceCovered(accel: i, time: race.rtime - i) > race.distance {
                    print(i)
                    count += 1
                }
            }
            print("Returning \(count)"    )
            return count
        }
        
        var runningTotal = 1
        for race in races {
            runningTotal *= countValidStats(race: race)
        }
        print(runningTotal)
    }
    
    func p2() throws {

        print("Hello, World!")
        var base = "/Users/paullocksley/Documents/LocksleyDev/Projects/AOC-2023/"
        var furl = "\(base)in.txt"

        furl = "\(base)in-real.txt"

        var p = try String(contentsOfFile: furl,encoding: .ascii)
        var o = p.split(separator: "\n")
        var time = Int(o[0].split(separator: " ")[1...].joined())!
        var dist = Int(o[1].split(separator: " ")[1...].joined())!


        func distanceCovered(accel: Int, time: Int) -> Int {
            return accel * time
        }

        func countValidStats(race: (rtime: Int, distance: Int)) -> Int{
            var count = 0
            var start = 0
            var end = 0
            for i in 1...race.rtime{
                if distanceCovered(accel: i, time: race.rtime - i) > race.distance {
                    print("Found winning start at \(i)")
                    start = i
                    break
                }
            }
            for i in (1...race.rtime).reversed(){
                if distanceCovered(accel: i, time: race.rtime - i) > race.distance {
                    print("Found winning end at \(i)")
                    end = i
                    break
                }
            }
            return end - start + 1
        }
        print(countValidStats(race: (rtime: time, distance: dist)))

    }
}
