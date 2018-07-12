//
//  TieGameInteractor.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs
import RxSwift

protocol TieGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TieGamePresentable: Presentable {
    var listener: TieGamePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol TieGameListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didDismissTieGame()
    func didExecuteTieGame()
}

final class TieGameInteractor: PresentableInteractor<TieGamePresentable>, TieGameInteractable, TieGamePresentableListener {

    weak var router: TieGameRouting?
    weak var listener: TieGameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: TieGamePresentable, tieStream: TieStream) {
        self.tieStream = tieStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - TieGamePresentableListener
    
    func dismissTieGame() {
        self.listener?.didDismissTieGame()
    }
    
    func executeTieGame() {
        self.listener?.didExecuteTieGame()
    }
    
    // MARK: - Private
    
    let tieStream: TieStream
    
}
