//
//  RootRouter.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable, viewController: RootViewControllable, loggedOutBuilder: LoggedOutBuildable) {
        
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
        
    }
    
    override func didLoad() {
        
        super.didLoad()
        
        let loggedOut = self.loggedOutBuilder.build(withListener: self.interactor)
        self.loggedOut = loggedOut
        self.attachChild(loggedOut)
        self.viewController.present(viewController: loggedOut.viewControllable)
        
        
    }
    
    // MARK: - Private
    
    private let loggedOutBuilder: LoggedOutBuildable
    
    private var loggedOut: ViewableRouting?
    
}
