//
//  SignUpViewController.swift
//  Login-firebase
//
//  Created by Johel Zarco on 17/05/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let stackView = UIStackView()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    let divider2 = UIView()
    let divider3 = UIView()
    let signUpButton = UIButton(configuration: .filled())
    let errorMessageLabel = UILabel()
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension SignUpViewController{
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        stackView.axis = .vertical
        stackView.spacing = 10 // spacing in between elements in stack
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.placeholder = "First name"
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.placeholder = "Last name"
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "email"
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "password"
        passwordTextField.isSecureTextEntry = true
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .systemTeal
        
        divider2.translatesAutoresizingMaskIntoConstraints = false
        divider2.backgroundColor = .systemTeal
        
        divider3.translatesAutoresizingMaskIntoConstraints = false
        divider3.backgroundColor = .systemTeal
        
        Utilities.styleButton(signUpButton, with: "Sign Up")
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .primaryActionTriggered)
        
        Utilities.styleLabel(label: errorMessageLabel)
        errorMessageLabel.text = "Your password must be at least 8 chars and contain a especial character and a number"
        errorMessageLabel.textColor = .systemGray
        errorMessageLabel.isHidden = false

        // from core animation, CAlayer
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
    }
    
    func layout(){
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(divider2)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(divider3)
        stackView.addArrangedSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(errorMessageLabel)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2).isActive = true
        // flip direction <- of constraints (loginView)
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2).isActive = true

        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        signUpButton.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 4).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signUpButton.bottomAnchor, multiplier: 2).isActive = true
        errorMessageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        errorMessageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
    }
}

extension SignUpViewController{
    // if everything is correct return nil, otherwise return error message
    
    private func validateFields() -> String?{
        // check if texts fields are filled
        if (firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            
            return "Please fill in all fields"
        }
        // check if password is secure against regex
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (Utilities.isPasswordValid(cleanPassword)) == false{
            //password isn't secure enoguh
            return "Please make sure your password is at least 8 chars, contains a especial char and a number"
        }
        return nil
    }
    
}

extension SignUpViewController{
    
    @objc func signUpTapped(sender : UIButton){
        print("signUp  Tapped!")
        errorMessageLabel.isHidden = true
        errorMessageLabel.textColor = .systemGray
        // validate fields
        let error = validateFields()
        if error != nil{
            // If there's an error on field's validation, display it and change label color
            showError(with: error!)
            errorMessageLabel.isHidden = false
            errorMessageLabel.textColor = .systemPink
        }else{
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Create user with firebase Auth
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if err != nil{
                    // there was an error while creating the doc
//                    print(err?.localizedDescription)
                    print("error while reaching auth")
                    self.showError(with: "Error with Auth.auth()")
                }else{
                    // user was created succesfully, now it's time for first and lastname in NS defaults
                    print("user created succesfully")
                    self.defaults.set(self.firstNameTextField.text, forKey: "first")
                    self.defaults.set(self.lastNameTextField.text, forKey: "last")
                    // transition to Home screen
                    self.setHome()
                }
            }
        }
    }
    
    private func showError(with message : String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
    private func setHome(){
        // transition to home user
        let homeVC = HomeViewController()
        homeVC.defaults = defaults
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

