//
//  SettingContainerView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

class SettingContainerView: UIView {

    private var topView = SettingButtonView()
    private var contentView = SettingContentView()
    
    private let initialFrameOfTopView = CGRect(x: .mainWidth - 62,
                                       y: 40,
                                       width: .mainWidth - 40,
                                       height: 60)
    
    private let fullFrame = CGRect(origin: .zero,
                                   size: CGSize(width: .mainWidth,
                                                height: .mainHeight))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    // 컨테이너의 frame이 변경될 때 subview 중 topView의 frame 또한 재설정 되어야 함.
    override var frame: CGRect {
        didSet(oldValue) {
            let newFrame = UIView(frame: oldValue).convert(self.topView.frame, to: self)
            self.topView.frame = newFrame
            print(newFrame)
        }
    }
    
    
    private func commoninit() {
        self.backgroundColor = .yellow
        self.addSubview(self.contentView)
        self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        self.topView = SettingButtonView(frame: self.bounds,
                                         radius: self.initialFrameOfTopView.height/2,
                                         bgColor: .red)//.cardBackground
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
    func didRecognizePanGesture(state: UIGestureRecognizer.State, intensity: CGFloat) {

        switch state {
        case .began:
            
            self.frame = self.fullFrame
            
            break
            
        case .ended:
            
            if intensity < 0.5 {
                self.frame = self.initialFrameOfTopView
            }
            
        default:
            break
        }
    }
    
    
    
}
