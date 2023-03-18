//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 13.03.23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = ""
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
    let buttonLogIn = UIButton(title: "Log In",
                               titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                               backgrondColor: #colorLiteral(red: 0.9568627451, green: 0.7294117647, blue: 0.9803921569, alpha: 1),
                               isShadow: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        setupConstraints()
        
        addTargetForButton()
        titleAnimation()
       
    }
    
  
    
    private func titleAnimation() {
        
        let text = "FlashChat"
        var count = 1.0
        
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * count, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            count += 1
        }
    }
    
    private func addTargetForButton() {
        
        buttonRegister.addTarget(self, action: #selector(registerPressed(_:)), for: .touchUpInside)
        buttonLogIn.addTarget(self, action: #selector(logInPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func registerPressed(_ sender: UIButton) {
        
        let registerController = RegisterViewController()
        self.navigationController?.pushViewController(registerController, animated: true)
    }
    
    @objc private func logInPressed(_ sender: UIButton) {
        let logInController = LoginViewController()
        self.navigationController?.pushViewController(logInController, animated: true)
    }
    
    
}
// MARK: - Setup Constraints
extension WelcomeViewController {
    
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

struct WelcomeVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarViewController = UINavigationController(rootViewController: WelcomeViewController())
        
        func makeUIViewController(context: Context) -> some UINavigationController {
            return tabBarViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}


