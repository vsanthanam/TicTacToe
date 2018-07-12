//
//  LoggedInInteractor.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToOffGame()
    func routeToTicTacToe()
    func routeToTieGame()

}

protocol LoggedInListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    init(mutableScoreStream: MutableScoreStream, mutableTieStream: MutableTieStream) {
        self.mutableScoreStream = mutableScoreStream
        self.mutableTieStream = mutableTieStream
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    // MARK: - OffGameListener via LoggedInInteractable
    func didStartGame() {
        
        self.router?.routeToTicTacToe()
        
    }
    
    // MARK: - TicTacToeListener via LoggedInInteractable
    func gameDidEnd(withWinner winner: PlayerType?) {
        if let winner = winner {
            mutableScoreStream.updateScore(withWinner: winner)
        }
        router?.routeToOffGame()
    }
    
    func gameDidTie() {
        
        self.router?.routeToTieGame()
        
    }
    
    // MARK: - TieGameListener via LoggedInInteractable
    
    func didDismissTieGame() {
        self.router?.routeToOffGame()
    }
    
    func didExecuteTieGame() {
        mutableTieStream.incrementTies()
        self.router?.routeToOffGame()
    }
    
    // MARK: - Private
    
    private let mutableScoreStream: MutableScoreStream
    private let mutableTieStream: MutableTieStream
}
