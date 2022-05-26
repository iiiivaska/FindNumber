//
//  SettingsTableViewController.swift
//  FindNumber
//
//  Created by Василий Буланов on 24.05.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var timeGameLabel: UILabel!
    @IBOutlet weak var switchTimer: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    func loadSettings() {
        timeGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) сек"
        switchTimer.isOn = Settings.shared.currentSettings.timeState
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10, 20, 30 , 40, 50, 60, 70, 80, 90, 100, 110, 120]
            }
        default:
            return
        }
    }
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timeState = sender.isOn
    }
    
    @IBAction func setDefaultSettings(_ sender: Any) {
        Settings.shared.setDefaultSettings()
        self.loadSettings()
    }
}
