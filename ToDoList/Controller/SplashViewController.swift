//
//  SplashViewController.swift
//  ToDoList
//
//  Created by ShahJee on 30/08/2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GotoLogin", sender: self)
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GotoRegister", sender: self)
    }
}
