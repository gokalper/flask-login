//
//  AppViewController.swift
//  flask-login
//
//  Created by Ercilasun, Gokalp on 12/26/18.
//  Copyright © 2018 Ercilasun, Gokalp. All rights reserved.
//

import UIKit


class AppViewController: UIViewController {
    
    var items = [(name: String, price: Double)]()
    // MARK: FIX LOG OUT TO SEGUE BACK....
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
}
   
    
    @IBAction func getItemsPressed(_ sender: Any) {
        APIClient.getItems { [weak self] (items) in
                self?.items = items
            
            print("Success \(items.count)")
            
            for item in items {
                print("item: \(item.name)")
            }
        }
//        navigationController?.popViewController(animated: true)
    }
    
    
    
}
