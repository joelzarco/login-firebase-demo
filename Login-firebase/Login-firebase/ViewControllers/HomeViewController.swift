//
//  HomeViewController.swift
//  Login-firebase
//
//  Created by Johel Zarco on 17/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeLabel = UILabel()
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

extension HomeViewController{
    func style(){
        let userFirstName = defaults.string(forKey: "first")
        if userFirstName != nil{
            print(userFirstName)
        }
        view.addSubview(homeLabel)
        view.backgroundColor = .systemPink
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.text = "Welcome Home \(userFirstName!)"
        homeLabel.textAlignment = .center
        homeLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    func layout(){
        
        homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
