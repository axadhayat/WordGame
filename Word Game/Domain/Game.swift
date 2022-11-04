//
//  Game.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import Foundation

class GameActivity{
    
    //Private properties
    private var wordPairs:[WordPair]
    private(set) var wrongAttempts = 0
    private(set) var rightAttempts = 0
    private var currentIndex = 0
    private var randomEngIndex = 0
    private var randomSpanishIndex = 0
    private var randomTranslationArray:[Int] = []
    
    // init
    init(pairs:[WordPair]) {
        wordPairs = pairs
    }
    
    // Public members
    func makeAttempt(answer:Bool){
        if answer{
            if randomEngIndex == randomSpanishIndex{
                rightAttempts = rightAttempts + 1
            } else{
                wrongAttempts = wrongAttempts + 1
            }
        }
        else{
            if randomEngIndex != randomSpanishIndex{
                rightAttempts = rightAttempts + 1
            } else{
                wrongAttempts = wrongAttempts + 1
            }
        }
    }
    
    func getWordPair() -> WordPair?{
        defer{
            currentIndex = currentIndex + 1
        }
        if wordPairs.count < 4{
            return nil
        }
        if currentIndex >= wordPairs.count{
            resetGameCounters()
        }
            
        generateRandomSpanishTranslations(probability: 4) // 4 = 25%
        if let randomSpanishWordIndex = randomTranslationArray.randomElement(){
            let englishWord = wordPairs[currentIndex].text_eng
            let spanishRandomWord = wordPairs[randomSpanishWordIndex].text_spa
            randomEngIndex = currentIndex
            randomSpanishIndex = randomSpanishWordIndex
            return WordPair.init(text_eng: englishWord, text_spa: spanishRandomWord)
        }
        return nil
    }
 
    
    // Private members
    private func resetGameCounters(){
        currentIndex = 0
        randomEngIndex = 0
        randomSpanishIndex = 0
    }

    private func generateRandomSpanishTranslations(probability:Int){
        randomTranslationArray.removeAll()
        randomTranslationArray.append(currentIndex)
//TODO:- Put in iteration
        randomTranslationArray.append((0..<wordPairs.count).random(without: randomTranslationArray))
        randomTranslationArray.append((0..<wordPairs.count).random(without: randomTranslationArray))
        randomTranslationArray.append((0..<wordPairs.count).random(without: randomTranslationArray))
    }
}

// Range extension
// Return non repeating random number excluding provided number
extension Range where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}
