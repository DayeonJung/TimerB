//
//  RoundedView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/14.
//

import UIKit

@IBDesignable
class RoundedView: UIView {

    @IBInspectable
    var cornerRadius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            setNeedsDisplay()
        }
    }
    
    var bgColor: UIColor = .white {
        didSet {
            self.backgroundColor = self.bgColor
            setNeedsDisplay()
        }
        
    }
    
    required init(frame: CGRect? = nil,
                  radius: CGFloat? = nil,
                  bgColor: UIColor = .white) {
        
        super.init(frame: frame == nil ? .zero : frame!)
        self.commoninit(radius: radius, bgColor: bgColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    
    func commoninit(radius: CGFloat? = nil,
                            bgColor: UIColor? = nil) {
        
        self.clipsToBounds = true
        self.cornerRadius = radius ?? self.cornerRadius
        
        if let backgroundColor = bgColor {
            self.bgColor = backgroundColor
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    
    
}
