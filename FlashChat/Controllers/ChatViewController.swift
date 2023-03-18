//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 14.03.23.
//

import Foundation
import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    var message: [Message] = [
        Message(sender: "1@2.com", body: "Heydfvfdbfdjbdbklnglbk ngdflkbnkldgnbkldgnbklgndlbkngkldbndglbln"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "What's up"),
        
    ]
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        return button
    }()
    let messageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Write a message..."
        textField.font = UIFont(name: "Apple SD Gothic Neo Medium", size: 14)
        return textField
    }()
    
    let logOutBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "LogOut"
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.8705882353, blue: 1, alpha: 1)
        
        setupConstraints()
        addTargetForButton()
        addBarButtonItem()
        createTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    private func createTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
       
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: K.cellIdentifier)
    }
    
    private func addBarButtonItem() {
        
        let logOutBarButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        title = K.appName
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = logOutBarButton
    }
    
    @objc private func logOut() {
        let firebase = Auth.auth()
        do {
            try firebase.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func addTargetForButton() {
        
       button.addTarget(self, action: #selector(sendPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func sendPressed(_ sender: UIButton) {
        print("Hello")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        let message = message[indexPath.row]
        cell.viewCell.labelMessage.text = message.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


// MARK: - Setup Constraints
extension ChatViewController {
    
    private func setupConstraints() {
        
        let viewChat = ViewForTFAndButton(button: button, textField: messageTextField)
        viewChat.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.8705882353, blue: 1, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(viewChat)
        viewChat.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            viewChat.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            viewChat.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewChat.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewChat.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewChat.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ChatVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarViewController = ChatViewController()
        
        func makeUIViewController(context: Context) -> some ChatViewController {
            return tabBarViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
