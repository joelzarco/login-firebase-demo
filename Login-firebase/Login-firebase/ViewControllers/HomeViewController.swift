//
//  HomeViewController.swift
//  Login-firebase
//
//  Created by Johel Zarco on 17/05/22.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    let homeLabel = UILabel()
    var defaults = UserDefaults.standard
    let logOutButton = UIButton(configuration: .filled())

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

extension HomeViewController{
    func style(){
        let userFirstName = defaults.string(forKey: "first")
        let lastname = defaults.string(forKey: "last")
        if let lastname = lastname {
            print(lastname)
        }
        if let userFirstName = userFirstName {
            print(userFirstName)
            homeLabel.text = "Welcome Home \(userFirstName)"
        }else{
            homeLabel.text = "Welcome home"
        }
        
        view.addSubview(homeLabel)
        view.addSubview(logOutButton)
        view.backgroundColor = .secondarySystemBackground
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        homeLabel.textAlignment = .center
        homeLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        Utilities.styleButton(logOutButton, with: "Log Out")
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .primaryActionTriggered)

    }
    
    func layout(){
        
        homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.topAnchor.constraint(equalTo: homeLabel.topAnchor, constant: 50).isActive = true
        
    }
    
    @objc func logOutTapped(){
        print("logOut Tapped")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
//            let mainVC = ViewController()
            navigationController?.popToRootViewController(animated: true) // thank God!!!
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
