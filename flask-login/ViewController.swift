//
//  ViewController.swift
//  flask-login
//
//  Created by Ercilasun, Gokalp on 12/25/18.
//  Copyright © 2018 Ercilasun, Gokalp. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func RegisterPressed(_ sender: Any) {
        
        guard let username = usernameTextField.text, let password = passwordTextField.text, username.count > 0, password.count > 0 else {
            return
        }
        APIClient.register(withUsername: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    
    @IBAction func LoginPressed(_ sender: Any) {
        
        guard let username = usernameTextField.text, let password = passwordTextField.text, username.count > 0, password.count > 0 else {
            return
        }
        
        APIClient.login(withUsername: usernameTextField.text!, password: passwordTextField.text!, completion: {
            let checkKey = UserDefaults.standard.bool(forKey: "login_token_retrieved")
            if checkKey {
                print("Segue !!")
                self.performSegue(withIdentifier: "goToApp", sender: self)
            }
        })
        
    }
    
    
    
}

