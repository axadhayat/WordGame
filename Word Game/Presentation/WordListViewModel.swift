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
    private var game:GameActivity?{
        didSet{
            if let _ = game {
                self.game?.delegate = self
            }
        }
    }
    private var currentPairIndex = 0
    let wordPair = PublishSubject<WordPair>()
    let wrongAttempt = PublishSubject<Int>()
    let rightAttempt = PublishSubject<Int>()
    let error = BehaviorRelay<String>(value: "")
    var attemptTimer:Timer?
    
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
                self.game = GameActivity.init(pairs: responseWordPairs,probability: 4)
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
            self.restartTimer()
        }
    }
    
    private func restartTimer(){
        self.attemptTimer?.invalidate()
        self.attemptTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
}

extension WordListViewModel:GameDelegate{
    func shouldFinishGame() {
        exit(0)
    }
}

extension WordListViewModel{
    func startGame(){
        if let game = game, let nextPair = game.getWordPair() {
            self.wordPair.onNext(nextPair)
            self.restartTimer()
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
    
    @objc func fireTimer() {
        print("Timer...")
        if let game = game{
            game.makeAttempt(answer: nil)
            prepareForNextAttempt()
            print("WRONG ATTEMPS:\(game.wrongAttempts) ,RIGHT ATTEMPS:\(game.rightAttempts) , ")
        }
    }
}
