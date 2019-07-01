//
//  Concentration.swift
//  CardConcentration
//
//  Created by Ralph Jazer Rebong on 6/30/19.
//  Copyright © 2019 Ralph Jazer Rebong. All rights reserved.
//

import Foundation

class Concentration
{
    var cards =  [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard {
                //check if cards match
                if matchIndex != index{
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = nil
                }
            } else {
                    // either no cards or 2 cards are face up
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = index
                    
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        
        // TODO: Shuffle the cards
        
    }
}
