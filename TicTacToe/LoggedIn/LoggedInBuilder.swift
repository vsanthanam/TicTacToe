//
//  LoggedInBuilder.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var loggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency> {

    let player1Name: String
    let player2Name: String
    
    var mutableScoreStream: MutableScoreStream {
        return shared { ScoreStreamImpl() }
    }
    
    var mutableTieStream: MutableTieStream {
        return shared { TieStreamImpl() }
    }
    
    init(dependency: LoggedInDependency, player1Name: String, player2Name: String) {
        
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(dependency: dependency)
        
    }
    
    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var loggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency, player1Name: player1Name, player2Name: player2Name)
        let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream, mutableTieStream: component.mutableTieStream)
        let offGameBuilder = OffGameBuilder(dependency: component)
        let ticTacToeBuilder = TicTacToeBuilder(dependency: component)
        let tieGameBuilder = TieGameBuilder(dependency: component)
        interactor.listener = listener
        return LoggedInRouter(interactor: interactor, viewController: component.loggedInViewController, offGameBuilder: offGameBuilder, ticTacToeBuilder: ticTacToeBuilder, tieGameBuilder: tieGameBuilder)
    }
}
