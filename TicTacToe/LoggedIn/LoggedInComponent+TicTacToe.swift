//
//  LoggedInComponent+TicTacToe.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the TicTacToe scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyTicTacToe: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the TicTacToe scope.
}

extension LoggedInComponent: TicTacToeDependency {

    // TODO: Implement properties to provide for TicTacToe scope.
}
