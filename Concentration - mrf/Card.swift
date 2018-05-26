//
//  Card.swift
//  Concentration - mrf
//
//  Created by Mark Foege on 4/30/18.
//  Copyright © 2018 Inobus. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var idenfierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        idenfierFactory += 1
        return idenfierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
