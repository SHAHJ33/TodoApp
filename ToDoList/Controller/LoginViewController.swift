//
//  LoginViewController.swift
//  ToDoList
//
//  Created by ShahJee on 30/08/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func OnLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginToHome", sender: self)
    }
}
