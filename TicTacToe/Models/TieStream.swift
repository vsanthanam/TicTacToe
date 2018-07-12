//
//  TieStream.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/12/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RxSwift

struct Tie {
    let ties: Int
    
    static func equals(lhs: Tie, rhs: Tie) -> Bool {
        return lhs.ties == rhs.ties
    }
}

protocol TieStream: class {
    var tie: Observable<Tie> { get }
}

protocol MutableTieStream: TieStream {
    func incrementTies()
}

class TieStreamImpl: MutableTieStream {
    var tie: Observable<Tie> {
        return self.variable .asObservable().distinctUntilChanged { (lhs: Tie, rhs: Tie) -> Bool in
            Tie.equals(lhs: lhs, rhs: rhs) }
    }
    
    func incrementTies() {
        let newTie: Tie = {
            let currentTie = self.variable.value
            return Tie(ties: currentTie.ties + 1)
        }()
        self.variable.value = newTie
    }
    
    // MARK: - Private
    
    private let variable = Variable<Tie>(Tie(ties: 0))
}
