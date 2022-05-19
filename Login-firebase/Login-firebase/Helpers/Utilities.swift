//
//  Utilities.swift
//  Login-firebase
//
//  Created by Johel Zarco on 18/05/22.
//

import Foundation
import UIKit

class Utilities{
    
    static func styleButton(_ button : UIButton, with text : String){
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.configuration?.titleAlignment = .center
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .systemTeal
        button.configuration?.buttonSize = .large
        button.configuration?.baseForegroundColor = .white
        button.configuration?.imagePadding = 8
        
    }
    
    static func styleLabel(label : UILabel){
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemPink
        label.numberOfLines = 0// multiline
        
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
