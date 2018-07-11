//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, TicTacToeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable, viewController: LoggedInViewControllable, offGameBuilder: OffGameBuildable, ticTacToeBuilder: TicTacToeBuildable) {
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        
        super.didLoad()
        self.attachOffGame()
        
    }
    
    // MARK: - LoggedInRouting
    
    func cleanupViews() {
        
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
        
    }
    
    func routeToOffGame() {
        
        self.detachCurrentChild()
        self.attachOffGame()
        
    }
    
    func routeToTicTacToe() {
        
        self.detachCurrentChild()
        self.attachTicTacToe()
        
    }

    // MARK: - Private

    private var currentChild: ViewableRouting?
    private let viewController: LoggedInViewControllable
    
    private let offGameBuilder: OffGameBuildable
    private let ticTacToeBuilder: TicTacToeBuildable
    
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
    
    private func attachOffGame() {
        
        let offGame = offGameBuilder.build(withListener: self.interactor)
        self.currentChild = offGame
        self.attachChild(offGame)
        self.viewController.present(viewController: offGame.viewControllable)
        
    }
    
    private func attachTicTacToe() {
        
        let ticTacToe = ticTacToeBuilder.build(withListener: self.interactor)
        self.currentChild = ticTacToe
        self.attachChild(ticTacToe)
        self.viewController.present(viewController: ticTacToe.viewControllable)
        
    }
    
}
