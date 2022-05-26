//
//  SelectTimeViewController.swift
//  FindNumber
//
//  Created by Василий Буланов on 24.05.2022.
//

import UIKit

class SelectTimeViewController: UIViewController {

    var data: [Int] = []
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SelectTimeViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: UITableViewDataSource
    // Создание строки таблицы на основе заданной
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = String(data[indexPath.row])
        return cell
    }
    
    // Количество строк в секции, есть еще метод для количества секций, по умолчанию 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // MARK: UITableViewDelegate
    // Метод для выбора строки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Settings.shared.currentSettings.timeForGame = data[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
}
