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
    func fetch()
    var wordPairs: BehaviorRelay<[WordPair]> { get }
    var error: BehaviorRelay<String> { get }
}

final class WordListViewModel : WordListViewModelProtocol{
    
    private let repository:Repository!
    let error = BehaviorRelay<String>(value: "")
    let wordPairs = BehaviorRelay<[WordPair]>(value: [])

    // Dependency injection

    init(_ wordlistRepository:Repository){
        repository = wordlistRepository
    }
    
    // Fetch data from local dataset
    
    func fetch() {
        repository.fetch { [weak self] (result: Response<BaseResponse>) in
            guard let self = self else { return }
            switch result{
            case .success(let response):
                self.wordPairs.accept(response.wordPairs)
            case .failure(let error):
                self.error.accept(error.localizedDescription)
            }
        }
    }
    
}
