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
}

final class TieGameViewController: UIViewController, TieGamePresentable, TieGameViewControllable {

    weak var listener: TieGamePresentableListener?
    
    // MARK: - Private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.buildAustinLabel()
        self.buildCloseButton()
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
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.backgroundColor = UIColor.black
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapCloseButton() {
        
        self.listener?.dismissTieGame()
        
    }
    
}
