//
//  UIButton + Extension.swift
//  FlashChat
//
//  Created by Андрей Фроленков on 13.03.23.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor,
                     backgrondColor: UIColor,
                     font: UIFont? = UIFont(name: "Apple SD Gothic Neo Medium", size: 30),
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 4) {
        
        self.init(type: .system)
        
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgrondColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
        
        
        
    }
}
