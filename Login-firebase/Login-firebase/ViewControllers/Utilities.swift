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
        
    }
    
}
