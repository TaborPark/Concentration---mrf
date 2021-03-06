//
//  Concentration.swift
//  Concentration - mrf
//
//  Created by Mark Foege on 4/30/18.
//  Copyright © 2018 Inobus. All rights reserved.
//

import Foundation

struct Concentration
{
    
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    
    private struct Points {
        static let matchBonus = 2
        static let missMatchPenalty = 1
    }

    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index is out of range")
        if !cards[index].isMatched {
                    flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
    // the cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
    // Increase the score
                score += Points.matchBonus
                cards[index].isFaceUp = true
            } else {
    // the cards did NOT match, so penalize
                if seenCards.contains(index) {
                    score -= Points.missMatchPenalty
                }
                if seenCards.contains(matchIndex) {
                    score -= Points.missMatchPenalty
                }
                seenCards.insert(index)
                seenCards.insert(matchIndex)
            }
            cards[index].isFaceUp = true
        } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }

    }
    
    mutating func resetGame (){
        flipCount = 0
        score = 0
        seenCards = []
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4random)
            swapAt(i, j)
        }
    }
}
