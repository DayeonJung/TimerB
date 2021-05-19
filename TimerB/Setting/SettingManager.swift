//
//  SettingManager.swift
//  TimerB
//
//  Created by 정다연 on 2021/05/12.
//

import Foundation
import UIKit

class SettingManager {
    
    private let keyWindow: UIWindow? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })

    private var buttonView: SettingButtonView
    private var contentView: SettingContentView
        
    
    init() {
        self.buttonView = SettingButtonView(frame: CGRect(x: .mainWidth - 62,
                                                          y: 40,
                                                          width: .mainWidth - 40,
                                                          height: 60),
                                            radius: 30,
                                            bgColor: .cardBackground)
        
        self.contentView = SettingContentView(frame: CGRect(origin: .zero,
                                                            size: CGSize(width: .mainWidth,
                                                                         height: .mainHeight)))
        self.contentView.delegate = self
        
        // add a view above all(even navigation bar)
        if self.keyWindow?.subviews.last?.isKind(of: SettingButtonView.self) == false {
            self.keyWindow?.addSubview(self.buttonView)
            self.buttonView.delegate = self
        }
        
    }
    
}


extension SettingManager: ButtonViewProtocol {
    
    func didRecognizePanGesture(state: UIGestureRecognizer.State, intensity: CGFloat) {

        switch state {
        case .began:
            
            self.keyWindow?.insertSubview(self.contentView, belowSubview: self.buttonView)
            break
        
        default:
            break
        }
        
        self.contentView.didRecognizePanGesture(state: state,
                                                intensity: intensity)
        
    }
    
    
}


extension SettingManager: ContentViewProtocol {
    
    func resetUIToInitialState() {
       
        self.buttonView.setAlpha(with: 1, animate: true)
        
    }
    
    
}
