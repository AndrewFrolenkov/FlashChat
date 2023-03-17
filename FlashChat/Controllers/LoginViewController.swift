//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 14.03.23.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let emailTextField = UITextField(text: "test26071994@gmail.com",placeholder: "Email")
    let passwordTextField = UITextField(text: "1236547qwe", placeholder: "Password")
    let logInButton = UIButton(title: "Log In", titleColor: #colorLiteral(red: 0.9568627451, green: 0.7294117647, blue: 0.9803921569, alpha: 1), backgrondColor: .clear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8243386149, green: 0.9464728236, blue: 1, alpha: 1)
        
        setupConstraints()
        addTargetForButton()
    }
    
    private func addTargetForButton() {
        
        logInButton.addTarget(self, action: #selector(logInPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func logInPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let low = email.lowercased()
        Auth.auth().signIn(withEmail: low, password: password) { [weak self] auth, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let registerController = ChatViewController()
                self?.navigationController?.pushViewController(registerController, animated: true)
            }
        }
        
    }
    
}

// MARK: - Setup Constraints
extension LoginViewController {
    
    private func setupConstraints() {
        
        let emailView = ViewForTextField(textField: emailTextField)
        let passwordView = ViewForTextField(textField: passwordTextField)
        
        let stackView = UIStackView(arrangedSubviews: [emailView,
                                                      passwordView,
                                                       logInButton],
                                    axis: .vertical,
                                    spacing: 10)
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        
        // stackView + emailView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}

// MARK: - SwiftUI
import SwiftUI

struct LoginVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarViewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> some LoginViewController {
            return tabBarViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

