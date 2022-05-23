//
//  RedViewController.swift
//  FindNumber
//
//  Created by Василий Буланов on 23.05.2022.
//

import UIKit

class RedViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var textForLabel = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = textForLabel
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goToGreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "greenVC") as? GreenViewController {
            vc.text = "kkkkk"
            vc.title = "Зеленый"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
