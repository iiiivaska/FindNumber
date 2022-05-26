//
//  GameViewController.swift
//  FindNumber
//
//  Created by Василий Буланов on 23.05.2022.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        self?.timerLabel.text = "\(time.secondsToString())"
        self?.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !Settings.shared.currentSettings.timeState {
            timerLabel.isHidden = true
        }
        setupScreen()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        updateUI()
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            //buttons[index].isHidden = false
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {
            //buttons[index].isHidden = game.items[index].isFound
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: GameStatus) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .cyan
            newGameButton.isHidden = false
            if game.isNewRecord {
                showAlert()
            } else {
                showAlertActionSheet()
            }
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Поздравляем", message: "Вы установили новый рекорд!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    // Показать popover
    private func showAlertActionSheet() {
        let alert = UIAlertController(title: "Что вы хотите сделать далее?", message: nil, preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Начать новую игру", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        
        let showRecord = UIAlertAction(title: "Посмотреть рекорд", style: .default) { (_) in
            //TODO: - Record View Controller
        }
        
        let menuAction = UIAlertAction(title: "Перейти в меню", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        //Выводим popover на айпаде по центру экрана
        if let popover = alert.popoverPresentationController {
            //popover.sourceView = statusLabel //Привязываем popover к определенному view
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        
        present(alert, animated: true)
    }
}
