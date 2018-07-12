//
//  TicTacToeInteractor.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs
import RxSwift

protocol TicTacToeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TicTacToePresentable: Presentable {
    var listener: TicTacToePresentableListener? { get set }
    
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setCell(atRow row: Int, col: Int, withPlayerType playerType: PlayerType)
    func announce(winner: PlayerType?, withCompletionHandler handler: @escaping () -> ())
}

protocol TicTacToeListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func gameDidEnd(withWinner: PlayerType?)
    func gameDidTie()
}

// MARK: - Interactor

final class TicTacToeInteractor: PresentableInteractor<TicTacToePresentable>, TicTacToeInteractable, TicTacToePresentableListener {
    weak var router: TicTacToeRouting?
    weak var listener: TicTacToeListener?
    
    // MARK: - Override
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TicTacToePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        self.initBoard()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - TicTacToePresentableListener
    
    func placeCurrentPlayerMark(atRow row: Int, col: Int) {
        guard board[row][col] == nil else {
            return
        }
        
        moveCount = moveCount + 1
        
        let currentPlayer = getAndFlipCurrentPlayer()
        self.board[row][col] = currentPlayer
        self.presenter.setCell(atRow: row, col: col, withPlayerType: currentPlayer)
        
        if let winner = checkWinner() {
            self.presenter.announce(winner: winner) {
                self.listener?.gameDidEnd(withWinner: winner)
            }
        } else if moveCount == 9 {
            self.listener?.gameDidTie()
        }
    }
    
    // MARK: - Private
    
    private var currentPlayer = PlayerType.player1
    private var board = [[PlayerType?]]()
    private var moveCount = 0
    
    private func initBoard() {
        for _ in 0..<GameConstants.rowCount {
            self.board.append([nil, nil, nil])
        }
    }
    
    private func getAndFlipCurrentPlayer() -> PlayerType {
        let currentPlayer = self.currentPlayer
        self.currentPlayer = currentPlayer == .player1 ? .player2 : .player1
        return currentPlayer
    }
    
    private func checkWinner() -> PlayerType? {
        // Rows.
        for row in 0..<GameConstants.rowCount {
            guard let assumedWinner = board[row][0] else {
                continue
            }
            var winner: PlayerType? = assumedWinner
            for col in 1..<GameConstants.colCount {
                if assumedWinner.rawValue != board[row][col]?.rawValue {
                    winner = nil
                    break
                }
            }
            if let w = winner {
                return w
            }
        }
        
        // Cols.
        for col in 0..<GameConstants.colCount {
            guard let assumedWinner = board[0][col] else {
                continue
            }
            var winner: PlayerType? = assumedWinner
            for row in 1..<GameConstants.rowCount {
                if assumedWinner.rawValue != board[row][col]?.rawValue {
                    winner = nil
                    break
                }
            }
            if let winner = winner {
                return winner
            }
        }
        
        // Diagnals.
        guard let p11 = board[1][1] else {
            return nil
        }
        if let p00 = board[0][0], let p22 = board[2][2] {
            if p00.rawValue == p11.rawValue && p11.rawValue == p22.rawValue {
                return p11
            }
        }
        
        if let p02 = board[0][2], let p20 = board[2][0] {
            if p02.rawValue == p11.rawValue && p11.rawValue == p20.rawValue {
                return p11
            }
        }
        
        return nil
    }
}

enum PlayerType: Int {
    case player1 = 1
    case player2
}

struct GameConstants {
    static let rowCount = 3
    static let colCount = 3
}
