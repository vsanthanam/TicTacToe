//
//  RootRouter.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
    
}

protocol RootViewControllable: ViewControllable {
    
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable, viewController: RootViewControllable, loggedOutBuilder: LoggedOutBuildable, loggedInBuilder: LoggedInBuildable) {
        
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        self.interactor.router = self
        
        
    }
    
    // MARK: - Overridden
    
    override func didLoad() {
        
        super.didLoad()
        
        let loggedOut = self.loggedOutBuilder.build(withListener: self.interactor)
        
        self.loggedOut = loggedOut
        self.attachChild(loggedOut)
        self.viewController.present(viewController: loggedOut.viewControllable)
        
    }
    
    // MARK: - RootRouting
    
    func routeToLoggedIn() {
        
        if let loggedOut = self.loggedOut {
            self.detachChild(loggedOut)
            self.viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }
        
        self.attachLoggedIn()
        
    }
    
    // MARK: - Private
    
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder: LoggedInBuildable
    
    private var loggedOut: ViewableRouting?
    
    private func attachLoggedIn() {
        
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        self.attachChild(loggedIn)
        
    }
    
}
