//
//  Concentration.swift
//  iOS11StanfordCourse-Assignment1
//
//  Created by Natxo Raga Llorens on 12/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


class Concentration {
    
    var cards = [Card]()
    var indexOfFaceUpCard: Int?
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isFaceUp && !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = nil
            }
            else {
                //either no cards or two cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = index
            }
        }
    }
    
}
