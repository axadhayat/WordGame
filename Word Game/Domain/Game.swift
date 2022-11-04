//
//  Game.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import Foundation

protocol GameDelegate : AnyObject{
    func shouldFinishGame()
}

protocol Game: AnyObject{
    var wordPairs:[WordPair] { get }
    var probabality:Int { get }
    var randomTranslationArray:[Int] { get }
    var wrongAttempts:Int { get }
    var rightAttempts:Int { get }
    var currentIndex:Int { get }
    var randomEngIndex:Int { get }
    var randomSpanishIndex:Int { get }
    func getWordPair() -> WordPair?
    func resetGameCounters()
    func generateRandomSpanishTranslations()
    init(pairs:[WordPair], probability:Int)
}

class GameActivity: Game{
   
    //Private properties
    internal var wordPairs:[WordPair]
    private(set) var probabality: Int
    private(set) var wrongAttempts = 0
    private(set) var rightAttempts = 0
    private(set) var currentIndex = 0
    private(set) var randomEngIndex = 0
    private(set) var randomSpanishIndex = 0
    private(set) var randomTranslationArray:[Int] = []
    
    weak var delegate:GameDelegate?
    
    // init
    required init(pairs:[WordPair], probability:Int) {
        self.wordPairs = pairs
        self.probabality = probability
    }
    
    // Public members
    func makeAttempt(answer:Bool?){
        
        if let answer = answer {
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
        else{
            wrongAttempts = wrongAttempts + 1
        }
        if wrongAttempts == 3 || wrongAttempts + rightAttempts == 15{
            delegate?.shouldFinishGame()
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
            
        generateRandomSpanishTranslations()
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
    internal func resetGameCounters(){
        currentIndex = 0
        randomEngIndex = 0
        randomSpanishIndex = 0
    }

    internal func generateRandomSpanishTranslations(){
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
