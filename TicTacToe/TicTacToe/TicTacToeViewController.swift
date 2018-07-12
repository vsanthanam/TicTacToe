//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by Varun Santhanam on 7/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol TicTacToePresentableListener: class {
    func placeCurrentPlayerMark(atRow row: Int, col: Int)
}

final class TicTacToeViewController: UIViewController, TicTacToePresentable, TicTacToeViewControllable {
    weak var listener: TicTacToePresentableListener?
    
    // MARK: - Initialize
    
    init(withPlayer1Name player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    // MARK: - Overridde
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.buildCollectionView()
    }
    
    // MARK: - TicTacToePresentable
    
    func setCell(atRow row: Int, col: Int, withPlayerType playerType: PlayerType) {
        let indexPathRow = row * GameConstants.colCount + col
        let cell = self.collectionView.cellForItem(at: IndexPath(row: indexPathRow, section: Constants.sectionCount - 1))
        cell?.backgroundColor = playerType.color
    }
    
    func announce(winner: PlayerType?, withCompletionHandler handler: @escaping () -> ()) {
        func victoryStringForPlayer(player: String) -> String {
            return player + " won!"
        }
        
        let winnerString: String = {
            if let winner = winner {
                switch winner {
                case .player1:
                    return victoryStringForPlayer(player: player1Name)
                case .player2:
                    return victoryStringForPlayer(player: player2Name)
                }
            } else {
                return "It's a draw!"
            }
        }()
        let alert = UIAlertController(title: winnerString, message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close Game", style: .default) { _ in
            handler()
        }
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private let player1Name: String
    private let player2Name: String
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: Constants.cellSize, height: Constants.cellSize)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
    private func buildCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(self.view.snp.center)
            maker.size.equalTo(CGSize(width: CGFloat(GameConstants.colCount) * Constants.cellSize, height: CGFloat(GameConstants.rowCount) * Constants.cellSize))
        }
    }
}

fileprivate struct Constants {
    static let sectionCount = 1
    static let cellSize: CGFloat = UIScreen.main.bounds.width / CGFloat(GameConstants.colCount)
    static let cellIdentifier = "TicTacToeCell"
    static let defaultColor = UIColor.white
}

// MARK: - UICollectionViewDataSource

extension TicTacToeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameConstants.rowCount * GameConstants.colCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        self.reset(cell: reusedCell)
        return reusedCell
    }
    
    private func reset(cell: UICollectionViewCell) {
        cell.backgroundColor = Constants.defaultColor
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
}

// MARK: - UICollectionViewDelegate

extension TicTacToeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row / GameConstants.colCount
        let col = indexPath.row - row * GameConstants.rowCount
        listener?.placeCurrentPlayerMark(atRow: row, col: col)
    }
}
