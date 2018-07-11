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
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    
    func routeToOffGame()
    func routeToTicTacToe()

}

protocol LoggedInListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    init(mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
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
    
    func gameDidEnd(withWinner winner: PlayerType?) {
        if let winner = winner {
            mutableScoreStream.updateScore(withWinner: winner)
        }
        router?.routeToOffGame()
    }
    
    // MARK: - Private
    
    private let mutableScoreStream: MutableScoreStream
}
