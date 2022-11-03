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
    var error: BehaviorRelay<String> { get }
}

final class WordListViewModel : WordListViewModelProtocol{
    
    private let repository:Repository!
    private var game:GameActivity?
    private var currentPairIndex = 0
    let wordPair = PublishSubject<WordPair>()
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
    
    private func nextMove(){
        if let game = game{
            self.wordPair.onNext(game.getNextPair())
        }
    }
    
}

extension WordListViewModel{
    func startGame(){
        if let game = game{
            self.wordPair.onNext(game.getNextPair())
        }
    }
    
    func didTapCorrect() {
        nextMove()
    }
    
    func didTapReject() {
        nextMove()
    }
}
