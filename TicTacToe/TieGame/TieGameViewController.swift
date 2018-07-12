//
//  TieGameViewController.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol TieGamePresentableListener: class {
    func dismissTieGame()
    func executeTieGame()
}

final class TieGameViewController: UIViewController, TieGamePresentable, TieGameViewControllable {

    weak var listener: TieGamePresentableListener?
    
    // MARK: - Private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.buildAustinLabel()
        self.buildCloseButton()
        self.buildTestButton()
    }
    
    private func buildAustinLabel() {
        
        let austinLabel = UILabel()
        austinLabel.font = UIFont.systemFont(ofSize: 18)
        austinLabel.backgroundColor = UIColor.clear
        austinLabel.textColor = UIColor.darkGray
        austinLabel.textAlignment = .center
        austinLabel.text = "Welcome To Austin."
        view.addSubview(austinLabel)
        austinLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(view.snp.center)
            maker.width.equalTo(view.snp.width)
            maker.height.equalTo(21)
        }
        
    }
    
    private func buildCloseButton() {
    
        let closeButton = UIButton()
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.left.equalTo(view.snp.left).offset(20)
            maker.right.equalTo(view.snp.right).offset(-20)
            maker.bottom.equalTo(view.snp.bottom).offset(-20)
            maker.height.equalTo(44)
        }
        closeButton.setTitle("Tie Game", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.backgroundColor = UIColor.black
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
    }
    
    private func buildTestButton() {
        
        let testButton = UIButton()
        view.addSubview(testButton)
        testButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.left.equalTo(view.snp.left).offset(20)
            maker.right.equalTo(view.snp.right).offset(-20)
            maker.bottom.equalTo(view.snp.bottom).offset(-84)
            maker.height.equalTo(44)
        }
        testButton.setTitle("Just Checking", for: .normal)
        testButton.setTitleColor(UIColor.white, for: .normal)
        testButton.backgroundColor = UIColor.black
        testButton.addTarget(self, action: #selector(didTapTestButton), for: .touchUpInside)
        
    }
    
    
    @objc private func didTapTestButton() {
        
        self.listener?.dismissTieGame()
        
    }
    
    @objc private func didTapCloseButton() {
        
        self.listener?.executeTieGame()
        
    }
    
}
