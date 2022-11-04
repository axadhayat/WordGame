//
//  ViewController.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class WordListViewController: UIViewController {
    
    //Private properties
    
    private let viewModel : WordListViewModelProtocol!
    private let bag = DisposeBag()
    private lazy var gameView : GameView = {
        let view = Word_Game.GameView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    
    // Dependency injection
    
    init(viewModel: WordListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Lifecycle
    override func loadView() {
        super.loadView()
        view.addSubview(gameView)
        self.setupSubviews()
        self.bindViews()
    }
    
    private func setupSubviews(){
        NSLayoutConstraint.activate(
            [gameView.topAnchor.constraint(equalTo: view.topAnchor),
             gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func bindViews(){
        viewModel.wordPair
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] wordPair in
                guard let self = self else { return }
            self.gameView.setWordTitles(
                englishWord: wordPair.text_eng,
                spanishWord: wordPair.text_spa)
        })
        .disposed(by: bag)
        
        viewModel.wrongAttempt
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] attemptCount in
                guard let self = self else { return }
            self.gameView.setWrongAttempt(count: attemptCount)
        })
        .disposed(by: bag)
        
        viewModel.rightAttempt
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] attemptCount in
                guard let self = self else { return }
            self.gameView.setRightAttempt(count: attemptCount)
        })
        .disposed(by: bag)
        
        viewModel.startGame()
    }
}

extension WordListViewController:GameViewDelegate{
    func didAcceptTranslation() {
        viewModel.didTapCorrect()
    }
    
    func didRejectTranslation() {
        viewModel.didTapReject()
    }
}

