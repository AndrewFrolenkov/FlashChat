//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 14.03.23.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
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
        loadMessages()
        navigationController?.navigationBar.isHidden = false
        
    }
    
    private func loadMessages() {
       
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener() {  querySnapshot, error in
            self.message = []
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshot = querySnapshot?.documents {
                    for doc in snapshot {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String,
                           let body = data[K.FStore.bodyField] as? String {
                             let newMessage = Message(sender: sender, body: body)
                            self.message.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let index = IndexPath(row: self.message.count - 1, section: 0 )
                                self.tableView.scrollToRow(at: index, at: .top, animated: true)
                            }
                            
                        }
                    }
                }
            }
        }
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
        guard let messageText = messageTextField.text,
              let messageSender = Auth.auth().currentUser?.email else { return}
       
        db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender,
                                                                  K.FStore.bodyField:messageText,
                                                                  K.FStore.dateField:Date().timeIntervalSince1970]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Good")
                DispatchQueue.main.async {
                    self.messageTextField.text = ""
                }
                
            }
        }
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
        if message.sender == Auth.auth().currentUser?.email {
            cell.imageMessageTwo.isHidden = true
            cell.imageMessage.isHidden = false
            cell.viewCell.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.viewCell.labelMessage.textColor = .black
        } else {
            cell.imageMessageTwo.isHidden = false
            cell.imageMessage.isHidden = true
            cell.viewCell.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.viewCell.labelMessage.textColor = .red
        }
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
            viewChat.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
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
