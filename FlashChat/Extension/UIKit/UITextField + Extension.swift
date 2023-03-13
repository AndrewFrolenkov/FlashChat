//
//  UITextField + Extension.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 14.03.23.
//

import Foundation
import UIKit

extension UITextField {
    
    convenience init(placeholder: String , font: UIFont? = UIFont(name: "Apple SD Gothic Neo Medium", size: 25)) {

        self.init(frame: .zero)
        
        self.textAlignment = .center
        self.placeholder = placeholder
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
