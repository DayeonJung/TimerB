//
//  SettingContainerView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

class SettingContainerView: UIView {

    private var topView = SettingButtonView()
    private var contentView: SettingContentView?
    
    private let initialFrameOfTopView = CGRect(x: .mainWidth - 62,
                                       y: 40,
                                       width: .mainWidth - 40,
                                       height: 60)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    
    private func commoninit() {
//        self.backgroundColor = .cyan
//        self.contentView.frame = self.initialFrameOfTopView
        
//        self.addSubview(self.contentView)
//        self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        self.topView.frame = self.initialFrameOfTopView
        self.topView.bgColor = .red//.cardBackground
        self.topView.cornerRadius = self.initialFrameOfTopView.height/2
        self.addSubview(self.topView)
        
        self.topView.delegate = self
    
        
        // add a view above all(even navigation bar)
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if keyWindow?.subviews.last?.isKind(of: SettingContainerView.self) == false {
            keyWindow?.addSubview(self)
        }
        
        
    }

    
}


extension SettingContainerView: ButtonViewProtocol {
    func didRecognizePanGesture(state: UIGestureRecognizer.State, point: CGPoint) {
        print(state, point)
    }
    
    
    
}
