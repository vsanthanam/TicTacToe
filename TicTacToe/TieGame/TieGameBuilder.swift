//
//  TieGameBuilder.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

protocol TieGameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TieGameComponent: Component<TieGameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TieGameBuildable: Buildable {
    func build(withListener listener: TieGameListener) -> TieGameRouting
}

final class TieGameBuilder: Builder<TieGameDependency>, TieGameBuildable {

    override init(dependency: TieGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TieGameListener) -> TieGameRouting {
        let _ = TieGameComponent(dependency: dependency)
        let viewController = TieGameViewController()
        let interactor = TieGameInteractor(presenter: viewController)
        interactor.listener = listener
        return TieGameRouter(interactor: interactor, viewController: viewController)
    }
}
