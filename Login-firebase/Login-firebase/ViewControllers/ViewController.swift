//
//  ViewController.swift
//  Login-firebase
//
//  Created by Johel Zarco on 17/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    let signUpButton = UIButton(configuration: .filled())
    let loginButton = UIButton(configuration: .filled())

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
    }

}

extension ViewController{
    // round filled buttons
    func setup(){
        
    }
    func style(){
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
        
        Utilities.styleButton(signUpButton, with: "Sign Up")
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .primaryActionTriggered)
        
        Utilities.styleButton(loginButton, with: "Log in")
        loginButton.addTarget(self, action: #selector(loginTapped), for: .primaryActionTriggered)
    }
    
    func layout(){
        
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalTo: signUpButton.widthAnchor).isActive = true
    }
}

extension ViewController{
    
    @objc private func signUpTapped(){
        print("signUp Tapped")
        //let signUpVC = SignUpViewController()
        //navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
    @objc private func loginTapped(){
        print("login Tapped")
        //let loginVC = LoginViewController()
        //navigationController?.pushViewController(loginVC, animated: true)
        
    }
}

