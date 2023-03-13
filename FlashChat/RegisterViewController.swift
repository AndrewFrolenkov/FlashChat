//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 13.03.23.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    let emailTextField = UITextField(placeholder: "Email")
    let passwordTextField = UITextField(placeholder: "Password")
    let registerButton = UIButton(title: "Register", titleColor: #colorLiteral(red: 0.9568627451, green: 0.7294117647, blue: 0.9803921569, alpha: 1), backgrondColor: .clear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8243386149, green: 0.9464728236, blue: 1, alpha: 1)
        setupConstraints()
    }
}

// MARK: - Setup Constraints
extension RegisterViewController {
    
    private func setupConstraints() {
        
        let emailView = ViewForTextField(textField: emailTextField)
        let passwordView = ViewForTextField(textField: passwordTextField)
        
        let stackView = UIStackView(arrangedSubviews: [emailView,
                                                      passwordView,
                                                      registerButton],
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

struct RegisterVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarViewController = RegisterViewController()
        
        func makeUIViewController(context: Context) -> some RegisterViewController {
            return tabBarViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
}

