//
//  MessageCell.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 18.03.23.
//

import Foundation
import UIKit

class MessageCell: UITableViewCell {
    
    let viewCell: CustomView = {
        let view = CustomView(frame: .zero)
        return view
    }()
    
    let imageMessage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "MeAvatar")
        return image
    }()
    
    let imageMessageTwo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "YouAvatar")
        return image
    }()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        viewCell.layer.cornerRadius = 10
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Setup Constraints
extension MessageCell {
    
    private func setupConstraints() {
        
       
        let stackView = UIStackView(arrangedSubviews: [imageMessageTwo, viewCell, imageMessage], axis: .horizontal, spacing: 20)
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMessage.heightAnchor.constraint(equalToConstant: 40),
            imageMessage.widthAnchor.constraint(equalToConstant: 40),
            imageMessageTwo.heightAnchor.constraint(equalToConstant: 40),
            imageMessageTwo.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        ])
    }
    
}
