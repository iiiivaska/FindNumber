//
//  Settings.swift
//  FindNumber
//
//  Created by Василий Буланов on 26.05.2022.
//

import Foundation

enum KeysUserDefaults {
    static let settingsGame = "settingsGame"
    static let recordGame = "recordGame"
}

struct SettingsGame: Codable {
    var timeState: Bool
    var timeForGame: Int
}

class Settings {
    static var shared = Settings()
    private let defaultSettings = SettingsGame(timeState: true, timeForGame: 30)
    
    var currentSettings: SettingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            }
            if let data = try? PropertyListEncoder().encode(defaultSettings) {
                UserDefaults.standard.set(data, forKey: KeysUserDefaults.settingsGame)
            }
            return defaultSettings
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: KeysUserDefaults.settingsGame)
            }
        }
    }
    
    func setDefaultSettings() {
        currentSettings = defaultSettings
    }
}
