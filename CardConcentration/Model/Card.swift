//
//  Card.swift
//  CardConcentration
//
//  Created by Ralph Jazer Rebong on 6/30/19.
//  Copyright © 2019 Ralph Jazer Rebong. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
