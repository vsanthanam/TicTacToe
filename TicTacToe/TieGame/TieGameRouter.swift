//
//  TieGameRouter.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs

protocol TieGameInteractable: Interactable {
    var router: TieGameRouting? { get set }
    var listener: TieGameListener? { get set }
}

protocol TieGameViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TieGameRouter: ViewableRouter<TieGameInteractable, TieGameViewControllable>, TieGameRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TieGameInteractable, viewController: TieGameViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
