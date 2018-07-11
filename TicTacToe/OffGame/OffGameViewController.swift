//
//  OffGameViewController.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol OffGamePresentableListener: class {
    
    func startGame()
    
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {

    weak var listener: OffGamePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        buildStartButton()
    }
    
    // MARK: - Private
    
    private func buildStartButton() {
        let startButton = UIButton()
        view.addSubview(startButton)
        startButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(self.view.snp.center)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(100)
        }
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.black
        startButton.addTarget(self, action: #selector(didTapStartGame), for: .touchUpInside)
    }
    
    @objc private func didTapStartGame() {
        
        self.listener?.startGame()
        
    }
    
}
