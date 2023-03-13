//
//  CustomUIView.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 14.03.23.
//

import Foundation
import UIKit

class ViewForTextField: UIView {
    
    let textField: UITextField
    
    init(textField: UITextField) {
        
        self.textField = textField
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension ViewForTextField {
    
    private func setupConstraints() {
        
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
