//
//  Color.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/24.
//

import Foundation
import UIKit

enum ColorString: String {
    case background = "Background"
    case cardBackground = "Card_Background"
}

extension UIColor {
    
    class var cardBackground: UIColor {
        let color = UIColor(red: 44.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        return UIColor(named: ColorString.cardBackground.rawValue) ?? color
    }
    
    class var background: UIColor {
        let color = UIColor(red: 17.0/255.0, green: 17.0/255.0, blue: 17.0/255.0, alpha: 1.0)
        return UIColor(named: ColorString.background.rawValue) ?? color
    }
    
}
