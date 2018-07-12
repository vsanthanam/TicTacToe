//
//  LoggedInComponent+TieGame.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the TieGame scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyTieGame: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the TieGame scope.
}

extension LoggedInComponent: TieGameDependency {

    // TODO: Implement properties to provide for TieGame scope.
    var tieStream: TieStream {
        return mutableTieStream
    }
}

