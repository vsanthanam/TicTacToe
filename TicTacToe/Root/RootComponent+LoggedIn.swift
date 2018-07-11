//
//  RootComponent+LoggedIn.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedIn scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyLoggedIn: Dependency {
    
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedIn scope.
    
}

extension RootComponent: LoggedInDependency {
    
    // TODO: Implement properties to provide for LoggedIn scope.
    
    var loggedInViewController: LoggedInViewControllable {
        
        return self.rootViewController
        
    }
    
}
