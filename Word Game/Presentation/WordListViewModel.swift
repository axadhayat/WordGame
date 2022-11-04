//
//  WordListViewModel.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import Foundation
import RxSwift
import RxRelay

protocol WordListViewModelProtocol{
    func didTapCorrect()
    func didTapReject()
    func startGame()
    var wordPair: PublishSubject<WordPair> { get }
    var wrongAttempt: PublishSubject<Int> { get }
    var rightAttempt: PublishSubject<Int> { get }
    var error: BehaviorRelay<String> { get }
}

final class WordListViewModel : WordListViewModelProtocol{
    
    private let repository:Repository!
    private var game:GameActivity?
    private var currentPairIndex = 0
    let wordPair = PublishSubject<WordPair>()
    let wrongAttempt = PublishSubject<Int>()
    let rightAttempt = PublishSubject<Int>()
    let error = BehaviorRelay<String>(value: "")

    // Dependency injection

    init(_ wordlistRepository:Repository){
        repository = wordlistRepository
        fetchWordlist()
    }
    
    // Fetch data from local dataset

    private func fetchWordlist(){
        repository.fetch { [weak self] (result: Response<[WordPair]>) in
            guard let self = self else { return }
            switch result{
            case .success(let responseWordPairs):
                self.game = GameActivity.init(pairs: responseWordPairs)
            case .failure(let error):
                self.error.accept(error.localizedDescription)
            }
        }
    }
    
    private func prepareForNextAttempt(){
        if let game = game, let nextPair = game.getWordPair() {
            self.wordPair.onNext(nextPair)
            self.wrongAttempt.onNext(game.wrongAttempts)
            self.rightAttempt.onNext(game.rightAttempts)
        }
    }
    
}

extension WordListViewModel{
    func startGame(){
        if let game = game, let nextPair = game.getWordPair() {
            self.wordPair.onNext(nextPair)
        }
        else{
            self.error.accept("Not enough values in dataset.")
        }
    }
    
    func didTapCorrect() {
        if let game = game{
            game.makeAttempt(answer: true)
            prepareForNextAttempt()
            print("WRONG ATTEMPS:\(game.wrongAttempts) ,RIGHT ATTEMPS:\(game.rightAttempts) ,")
        }
    }
    
    func didTapReject() {
        if let game = game{
            game.makeAttempt(answer: false)
            prepareForNextAttempt()
            print("WRONG ATTEMPS:\(game.wrongAttempts) ,RIGHT ATTEMPS:\(game.rightAttempts) , ")
        }
    }
}
