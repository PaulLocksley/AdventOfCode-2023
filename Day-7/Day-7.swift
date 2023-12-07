//
//  main.swift
//  AOC-2023
//
//  Created by paul locksley on 4/12/2023.
//

import Foundation

print("Hello, World!")


func replaceCards(_ s:[Character]) -> String {
  //take advantage of default string comparison.
    var s2:[Character] = []
    for c in s {
        switch c {
        case "T":
            s2.append("a")
        case "J":
            s2.append("1")
        case "Q":
            s2.append("c")
        case "K":
            s2.append("d")
        case "A":
            s2.append("e")
        default:
            s2.append(c)
        }
    }
    return String(s2)
}

struct Hand: Comparable {
    public let cards:String
    public let score: Int
    public let bet:Int
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.score == rhs.score {
            return lhs.cards < rhs.cards
        }
        return lhs.score < rhs.score
    }
}
func actuallyScoreHand(_ cards:[Character:Int] ) -> Int {
  //I wont defend this.
    var ThreePairFound = false
    var twoPairFound = false
    var minScore = 0
    for k in cards{
        switch k.value {
        case 5:
            return 7
        case 4:
            return 6
        case 3:
            if twoPairFound{
                return 5
            }
            minScore = 3 //three pair
            ThreePairFound = true
        case 2:
            if ThreePairFound{
                return 5
            }
            if twoPairFound{
                return 2
            }
            twoPairFound = true
            minScore =     1
        default:
            continue
        }
    }
    return minScore
}
func generateHands(_ cards:[Character:Int]) -> [[Character:Int]]{
    //Generate all versions of a hand, this isn't actually that bad because we limit it to cards we have.
    var hands:[[Character:Int]] = []
    var j = cards["J"] ?? 0
    if j == 0 {
        return [cards]
    }
    j -= 1
    var tmpHands:[[Character:Int]] = []
    for kv in cards {
        if(kv.key == "J"){ continue }
        var newHand = cards
        newHand[kv.key]! += 1
        newHand["J"] = j
        tmpHands.append(newHand)
    }
    
    if j > 0 {
        for hand in tmpHands {
            let newCards = generateHands(hand)
            hands.append(contentsOf: newCards)
        
        }
    }else{
        hands.append(contentsOf: tmpHands)
    }
    return hands
}

func scoreHand(_ s:[Character]) -> Int {
    var cards:[Character:Int] = [:]
    for c in s {
        if cards[c] != nil{
            cards[c]! += 1
        }else{
            cards[c] = 1
        }
    }
    if cards["J"] == 5 {
        return 7
    }
    let allHands = Set(generateHands(cards))
    var handMax = 0
    
    
    for hand in allHands{
        handMax = max(actuallyScoreHand(hand),handMax)
        if handMax == 7 {
            break
        }
    }
    return handMax
}



func main() throws {
    print("Hello, World!")
    let base = "/Users/paullocksley/Documents/LocksleyDev/Projects/AOC-2023/"
    var furl = "\(base)in.txt"
    		
    furl = "\(base)in-real.txt"
    
    let p = try String(contentsOfFile: furl,encoding: .ascii)
    let o = p.split(separator: "\n")
    
    var hands:[Hand] = []
    for hand in o {
        let tmp = hand.split(separator: " ")
        let tmpHand = ([Character](tmp[0]))
        hands.append(Hand(cards: replaceCards(tmpHand),
                        score: scoreHand(tmpHand),
                          bet: Int(tmp[1])!
                          ))
    }
    hands.sort()
    var score = 0
    var i = 1
    for hand in hands {
        score += hand.bet * i
        i += 1
    }
    print(score)
}

try main()
