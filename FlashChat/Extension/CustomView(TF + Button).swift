//
//  CustomView(TF + Button).swift
//  FlashChat
//
//  Created by Андрей Фроленков on 14.03.23.
//

import Foundation
import UIKit

class ViewForTFAndButton: ViewForTextField {
    
    let button: UIButton
    
    init(button: UIButton, textField: UITextField) {
        self.button = button
        super.init(textField: textField)
        
        setupConstraints()
        self.layer.cornerRadius = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension ViewForTFAndButton {
    
    private func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [textField, button],
                                    axis: .horizontal,
                                    spacing: 10)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                button.heightAnchor.constraint(equalToConstant: 50),
                button.widthAnchor.constraint(equalToConstant: 50)
            ])
    }
}
