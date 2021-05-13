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
    
    private let initialFrame = CGRect(x: .mainWidth - 62,
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
            
            self.contentView.frame = self.bounds
        }
    }
    
    
    private func commoninit() {

        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds

        self.topView.frame = self.bounds
        self.topView.cornerRadius = self.initialFrame.height/2
        self.topView.bgColor = .red//.cardBackground
        self.addSubview(self.topView)
        
        self.topView.delegate = self
        self.contentView.delegate = self
        
        // add a view above all(even navigation bar)
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if keyWindow?.subviews.last?.isKind(of: SettingContainerView.self) == false {
            keyWindow?.addSubview(self)
        }
//        keyWindow?.rootViewController?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        
    }

    
}


extension SettingContainerView: ButtonViewProtocol {
    func didRecognizePanGesture(state: UIGestureRecognizer.State, intensity: CGFloat) {

        let lengthToSlide = self.initialFrame.minX
        let changedX = lengthToSlide - self.topView.frame.minX
        let intensity = min(changedX * 10, lengthToSlide) / lengthToSlide    // 0 < intensity <= 1
                
        switch state {
        case .began:
            
            self.frame = self.fullFrame
            
            break
            
        case .changed:
//            self.topView.setCenter(with: transitionX)
            self.topView.setAlpha(with: 1 - intensity)
            
//            self.contentView.setBlur(with: intensity)
            break
            
        case .ended:
            
            if intensity < 0.5 {    // 원래 버튼으로 돌아온다
                
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
                    self.frame = self.initialFrame
                    self.topView.frame = self.bounds
                    self.topView.setAlpha(with: 1)
                } completion: { _ in }


            } else {    // 설정 창이 열린다
                self.topView.setAlpha(with: 0)
//                self.contentView.setBlur(with: 1)

            }
            break
            
        default:
            break
        }
        
        
    }
    
    
    
}

extension SettingContainerView: ContentViewProtocol {
    func resetUIToInitialState() {
        UIView.animate(withDuration: 0.4) {
            self.contentView.alpha = 0

        } completion: { _ in

            self.contentView.alpha = 1
            
            self.frame = self.initialFrame
            self.topView.frame = self.bounds
            self.topView.setAlpha(with: 1)
            


        }
    }
    
    
    
}
