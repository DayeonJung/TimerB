//
//  IconButton.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import Foundation
import UIKit

struct IconButtonModel {
    let imageName: String
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
            self.setImage(UIImage(systemName: icon), for: .normal)
        }
        
    }
    
    @objc private func clickAction(button: UIButton) {
        self.onClick()
    }
}

