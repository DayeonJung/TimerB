//
//  IconButton.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import Foundation
import UIKit

enum Icon: String {
    case Plus = "plus"
    case Minus = "minus"
    case Play = "play.fill"
    case Pause = "pause.fill"
    case GearShape = "gearshape"
}

struct IconButtonModel {
    let imageName: Icon
    let bgColor: UIColor
    let tintColor: UIColor
    
    init(imageName: Icon, bgColor: UIColor = .black, tintColor: UIColor = .white) {
        self.imageName = imageName
        self.bgColor = bgColor
        self.tintColor = tintColor
    }
}

@IBDesignable
class IconButton: UIButton {
    
    private var viewModel: IconButtonModel? {
        didSet {
            self.setUI()
        }
    }
    
    public var onClick = { () }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        
        self.setTitle(nil, for: .normal)

        self.layer.cornerRadius = self.bounds.height/2
        self.clipsToBounds = true
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
        self.tintColor = .white
        
        self.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
    }
    
    public func setModel(with viewModel: IconButtonModel) {
        self.viewModel = viewModel
    }
    
    private func setUI() {
        
        if let icon = self.viewModel?.imageName {
            self.setImage(UIImage(systemName: icon.rawValue), for: .normal)
        }
        
        self.backgroundColor = self.viewModel?.bgColor
        self.tintColor = self.viewModel?.tintColor
        
    }
    
    @objc private func clickAction(button: UIButton) {
        self.onClick()
    }
}

