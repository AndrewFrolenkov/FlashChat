//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 13.03.23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "FlashChat"
        titleLabel.textColor = #colorLiteral(red: 0.9989965558, green: 0.7177072167, blue: 0.9971507192, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 45, weight: .black)
        return titleLabel
    }()
    
    let titleImage: UIImageView = {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "lightning")
        return titleImage
    }()
    
    let buttonRegister = UIButton(title: "Register",
                                  titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                  backgrondColor: #colorLiteral(red: 0.9568627451, green: 0.7294117647, blue: 0.9803921569, alpha: 1),
                                  isShadow: true)
    let buttonLogIn = UIButton(title: "LogIn",
                               titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                               backgrondColor: #colorLiteral(red: 0.9568627451, green: 0.7294117647, blue: 0.9803921569, alpha: 1),
                               isShadow: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
    }
    
    
}

extension RegisterViewController {
    
    private func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [titleImage, titleLabel], axis: .horizontal, spacing: 10)
        
        let stackButton = UIStackView(arrangedSubviews: [buttonRegister, buttonLogIn], axis: .vertical, spacing: 10)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(stackButton)
        
        // Stack for title + imageView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleImage.heightAnchor.constraint(equalToConstant: 50),
            titleImage.widthAnchor.constraint(equalToConstant: 50)
        ])
        // Stack for button
        NSLayoutConstraint.activate([
            
            stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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


