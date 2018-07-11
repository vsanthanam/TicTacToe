//
//  RootBuilder.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let rootViewController: RootViewController
    
    init(dependency: RootDependency, rootViewController: RootViewController) {
        
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
        
    }
    
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    
    func build() -> LaunchRouting
    
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        
        super.init(dependency: dependency)
        
    }

    func build() -> LaunchRouting {
        
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        let interactor = RootInteractor(presenter: viewController)
        
        return RootRouter(interactor: interactor, viewController: viewController, loggedOutBuilder: loggedOutBuilder, loggedInBuilder: loggedInBuilder)
        
    }
    
}
