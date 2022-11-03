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
    
    private let viewModel : WordListViewModelProtocol!
    private let bag = DisposeBag()
    
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
        self.configureViews()
        self.bindViews()
    }
    
    private func configureViews(){
        self.view.backgroundColor = .red
    }
    
    
    private func bindViews(){
        self.viewModel.fetch()

    }
}

