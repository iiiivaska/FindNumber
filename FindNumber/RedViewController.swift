//
//  RedViewController.swift
//  FindNumber
//
//  Created by Василий Буланов on 23.05.2022.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func goToGreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "greenVC")
        vc.title = "Зеленый"
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
