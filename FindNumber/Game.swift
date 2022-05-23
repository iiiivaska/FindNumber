//
//  Game.swift
//  FindNumber
//
//  Created by Василий Буланов on 23.05.2022.
//

import Foundation

enum GameStatus {
    case start
    case win
    case lose
}

class Game {
    
    struct Item {
        var title: String
        var isFound = false
        var isError = false
    }
    
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame)
        }
    }
    
    private var timeForGame: Int
    
    private var timer: Timer?
    
    var status: GameStatus = .start {
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }
    
    private let data = Array(1...99)
    
    var items: [Item] = []
    
    private var countItems: Int
    
    var nextItem: Item?
    
    private var updateTimer: ((GameStatus,Int) -> Void)
    
    init(countItems: Int, time: Int, updateTimer: @escaping (_ status: GameStatus, _ seconds: Int) -> Void) {
        self.countItems = countItems
        self.secondsGame = time
        self.timeForGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
    
    func check(index: Int) {
        guard status == .start else { return }
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(item) -> Bool in
                item.isFound == false
            })
        } else {
            items[index].isError = true
        }
        
        if nextItem == nil {
            status = .win
        }
    }
    
    private func setupGame() {
        var digits = data.shuffled()
        items.removeAll()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            self?.secondsGame -= 1
        })
        updateTimer(status, secondsGame)
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
    
    func newGame() {
        status = .start
        setupGame()
        self.secondsGame = self.timeForGame
        
    }
    
}

extension Int {
    func secondsToString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
