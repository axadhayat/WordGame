//
//  GameView.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import UIKit

class GameView: UIView {
            
    //Private Properties
  
    private lazy var btnStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        view.addArrangedSubview(btnCorrectTranslation)
        view.addArrangedSubview(btnWrongTranslation)
        return view
    }()
    
    private lazy var resultStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        view.addArrangedSubview(lblCorrectAttempts)
        view.addArrangedSubview(lblWrongAttempts)
        return view
    }()
    
    private lazy var lblCorrectAttempts : UILabel = {
        let lbl = UILabel()
        lbl.text = "Correct attempts: 0"
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var lblWrongAttempts : UILabel = {
        let lbl = UILabel()
        lbl.text = "Wrong attempts: 0"
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var lblEnglishWord : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "English"
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var lblSpanishWord : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Spanish"
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var btnCorrectTranslation: UIButton = {
        let btn = UIButton.init()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 24
        btn.setTitle("Correct", for: .normal)
        btn.addTarget(self, action: #selector(didTapCorrect(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btnWrongTranslation: UIButton = {
        let btn = UIButton.init()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemRed
        btn.layer.cornerRadius = 24
        btn.setTitle("Wrong", for: .normal)
        btn.addTarget(self, action: #selector(didTapWrong(_:)), for: .touchUpInside)
        return btn
    }()
    
    // Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.init(red: 21, green: 21, blue: 21, alpha: 1)
        addSubview(resultStackView)
        addSubview(btnStackView)
        addSubview(lblEnglishWord)
        addSubview(lblSpanishWord)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Private members
    
    private func setupSubviews(){
        NSLayoutConstraint.activate(
            [resultStackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
             resultStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
             lblEnglishWord.centerXAnchor.constraint(equalTo: centerXAnchor),
             lblEnglishWord.centerYAnchor.constraint(equalTo: centerYAnchor),
             lblSpanishWord.centerXAnchor.constraint(equalTo: centerXAnchor),
             lblSpanishWord.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 40),
             btnStackView.heightAnchor.constraint(equalToConstant: 50),
             btnStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
             btnStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             btnStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
            ])
    }
    
    // Action
    
    @objc func didTapCorrect(_ button: UIButton){
        
    }
    
    @objc func didTapWrong(_ button: UIButton){
        
    }
    
}
