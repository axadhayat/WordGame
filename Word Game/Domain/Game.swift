//
//  Game.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import Foundation

class GameActivity{
    var wordPairs:[WordPair]
    var wrongAttempts = 0
    var rightAttempts = 0
    var currentPairIndex = 0
    
    init(pairs:[WordPair]) {
        wordPairs = pairs
    }
    
    func getNextPair() -> WordPair{
        defer{
            currentPairIndex = currentPairIndex + 1
        }
        return wordPairs[currentPairIndex]
    }
}
