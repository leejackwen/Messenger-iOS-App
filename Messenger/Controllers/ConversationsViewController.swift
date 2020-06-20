//
//  ViewController.swift
//  Messenger
//
//  Created by Jack on 16/06/2020.
//  Copyright © 2020 Jack Lee. All rights reserved.
//

import UIKit
import Firebase

class ConversationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        validateAuth()

    }
    
    private func validateAuth() {
        if Firebase.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    
    
    
    
    
}

