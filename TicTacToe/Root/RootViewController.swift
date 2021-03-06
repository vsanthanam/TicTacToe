//
//  RootViewController.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable, LoggedInViewControllable {

    weak var listener: RootPresentableListener?
    
    // MARK: - RootViewControllable
    
    func present(viewController: ViewControllable) {
        
        self.present(viewController.uiviewController, animated: true, completion: nil)
        
    }
    
    func dismiss(viewController: ViewControllable) {
        
        if presentedViewController === viewController.uiviewController  {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}
