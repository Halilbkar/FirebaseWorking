//
//  Textfield+Extension.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import Foundation
import UIKit

extension UITextField {
    func addRightImageButton(image: UIImage, target: Any?, action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24) // Button boyutunu ayarlayın
        button.contentMode = .scaleAspectFit
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24)) // Button için bir konteyner görünümü oluşturun
        rightView.addSubview(button)
        
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    func addLeftPadding(textField: UITextField) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
    }
}
