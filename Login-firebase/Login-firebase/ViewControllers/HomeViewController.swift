//
//  HomeViewController.swift
//  Login-firebase
//
//  Created by Johel Zarco on 17/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension HomeViewController{
    func style(){
        view.addSubview(homeLabel)
        view.backgroundColor = .systemPink
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.text = "Welcome"
        homeLabel.textAlignment = .center
        homeLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    func layout(){
        
        homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
