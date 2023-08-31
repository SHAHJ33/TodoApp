//
//  RegisterViewController.swift
//  ToDoList
//
//  Created by ShahJee on 30/08/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func OnRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "RegisterToHome", sender: self)
    }
}
