//
//  ViewCell.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 18.03.23.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    let labelMessage: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.lightPurple)
        label.numberOfLines = 20
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupConstraints()
        backgroundColor = UIColor(named: K.BrandColors.purple)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension CustomView {
    
    private func setupConstraints() {
        addSubview(labelMessage)
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelMessage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            labelMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            
        ])
    }
    
    
}
