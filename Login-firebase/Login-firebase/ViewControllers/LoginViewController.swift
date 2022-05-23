//
//  LoginViewController.swift
//  Login-firebase
//
//  Created by Johel Zarco on 17/05/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let stackView = UIStackView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    let signInButton = UIButton(configuration: .filled())
    let errorMessageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension LoginViewController{
    
    private func style(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        stackView.axis = .vertical
        stackView.spacing = 8 // spacing in between elements in stack
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "email"

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "password"
        passwordTextField.isSecureTextEntry = true
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .systemTeal
    
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        Utilities.styleButton(signInButton, with: "Log in")
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        Utilities.styleLabel(label: errorMessageLabel)
        errorMessageLabel.text = ""
        errorMessageLabel.isHidden = true
        
    }
    
    private func layout(){
        view.addSubview(stackView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2).isActive = true
        // flip direction <- of constraints (loginView)
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2).isActive = true

        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        signInButton.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2).isActive = true
        errorMessageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        errorMessageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

    }
}

extension LoginViewController{
    
    @objc func signInTapped(sender : UIButton){
        print("signIn Tapped!")
        // Check for empty fields
        let error = validateFields()
        if error != nil {
            // there is an error in some field
            showError(with: error!)
            errorMessageLabel.isHidden = false
            errorMessageLabel.textColor = .systemPink
            showError(with: "Please fill in all fields")
        } else{
            // Create cleaned versions of the text field
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    // Couldn't sign in
                    self.errorMessageLabel.text = error!.localizedDescription
                    self.errorMessageLabel.isHidden = false
                    self.showError(with: error!.localizedDescription)
                }
                else {
                    //
                    print("SigIn successfully")
                    // Transition to homeView
                    self.setHome()
                }
            }
        }// endElse Auth
    } // tapped
    
}

extension LoginViewController{
    // if everything is correct return nil, otherwise return error message
    private func validateFields() -> String?{
        // check if texts fields are filled
        if (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
    
    private func showError(with message : String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
    private func setHome(){
        // transition to home user
        let homeVC = HomeViewController()
//        homeVC.defaults = defaults
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
}
