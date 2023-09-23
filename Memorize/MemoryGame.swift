//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Christophe on 21/09/2023.
//

import Foundation

struct MemorizeGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
