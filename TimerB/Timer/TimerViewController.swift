//
//  TimerViewController.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/08.
//

import UIKit

class TimerViewController: UIViewController {

    var timerViewModel: TimerViewModelProtocol? {
        didSet {
            
            self.timerViewModel?.timeDidChage = { time in
                self.timeLabel.text = String(time)
                self.timeLabel.textColor = time <= 3 ? .systemRed : .white
            }
            
            self.timerViewModel?.playerDidChange = { player in
                self.waveView.shouldInit(with: player.color)
            }
            
            self.timerViewModel?.timerStop = { state in
                let iconName = state ? Icon.Play.rawValue : Icon.Pause.rawValue
                self.playButton.setImage(UIImage(systemName: iconName), for: .normal)
                self.waveView.shouldStop = state
            }
        }
    }
    

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: IconButton!
    

    var waveView: WaveView!
    
    
    var settingView: SettingView?
    var settingTopView: SettingTopView!
    let initialXSettingTop: CGFloat = .mainWidth - 62
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeLabel.text = String(self.timerViewModel?.currentTime ?? 99)
        
        self.initSettingTopView()
        self.initWaveView()
        self.setBottomButtonsUI()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        // Timer 해제
        self.timerViewModel?.shouldStop = true
    }
    
    
    private func initWaveView() {
        self.waveView = WaveView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: .mainWidth,
                                               height: .mainHeight),
                                 bgColor: self.timerViewModel?.playerInfo.first?.color ?? UIColor.white,
                                 maxTime: self.timerViewModel?.getMaxTime() ?? 99)
        
        self.view.insertSubview(self.waveView, at: 0)
        
        self.waveView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didClickBackground)))
    }
    
    @objc private func didClickBackground() {
        self.timerViewModel?.shouldGoToNextPlayer(to: .Next)
    }
    
    
    private func initSettingTopView() {
        
        let initialSize = CGSize(width: .mainWidth - 40, height: 60)
        self.settingTopView = SettingTopView(frame: CGRect(x: self.initialXSettingTop,
                                                           y: 40,
                                                           width: initialSize.width,
                                                           height: initialSize.height),
                                             radius: initialSize.height/2,
                                             bgColor: UIColor.cardBackground)
        self.settingTopView.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                         action: #selector(self.didPanSettingView)))
        
    }
    
    @objc private func didPanSettingView(_ sender: UIPanGestureRecognizer) {
        
        let transition = sender.translation(in: self.settingTopView)
        let changedX = self.settingTopView.center.x + transition.x
        let maintainingY = self.settingTopView.center.y
        
        self.settingTopView.setCenter(to: CGPoint(x: changedX, y: maintainingY))
        
        sender.setTranslation(.zero, in: self.settingTopView)
        
        
        switch sender.state {
        case .began:
            self.settingView = SettingView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: .mainWidth,
                                                         height: .mainHeight))
            self.view.addSubview(self.settingView!)

            self.settingView?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                          action: #selector(self.didTapSettingView)))
            
            break
            
        case .changed:
            let changedAmount = self.initialXSettingTop - self.settingTopView.frame.minX
            let intensity = min(changedAmount * 6, self.initialXSettingTop) / self.initialXSettingTop    // 0 < intensity <= 1

            self.settingView?.adjustAlphaOfBlurView(alpha: intensity)
            self.settingTopView.alpha = 1 - intensity

            break
            
        case .ended:
            let changedAmount = self.initialXSettingTop - self.settingTopView.frame.minX
            let intensity = min(changedAmount * 10, self.initialXSettingTop) / self.initialXSettingTop    // 0 < intensity <= 1

            if intensity > 0.5 {
                self.settingView?.setOpenedViewUI()
                self.initSettingTopView(alpha: 0)
            } else {
                self.settingView?.removeFromSuperview()
                self.initSettingTopView(alpha: 1)
            }
   
            break
            
        default:
            break
        }
        
    }
    
    @objc private func didTapSettingView() {
        
        guard let setting = self.settingView else { return }
        
        UIView.animate(withDuration: 0.4) {
            
            self.initSettingTopView(alpha: 1)
            
            self.settingView?.noticeContainer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            setting.alpha = 0
            
        } completion: { _ in
            setting.removeFromSuperview()
        }
        
    }
    
    private func initSettingTopView(alpha: CGFloat) {
        self.settingTopView.frame = CGRect(x: self.initialXSettingTop,
                                           y: self.settingTopView.frame.minY,
                                           width: self.settingTopView.frame.width,
                                           height: self.settingTopView.frame.height)
        self.settingTopView.alpha = alpha
    }

    private func setBottomButtonsUI() {
        self.playButton.setModel(with: IconButtonModel(imageName: .Pause,
                                                       bgColor: .white,
                                                       tintColor: UIColor.background))
        
        self.playButton.onClick = {
            let state = self.timerViewModel?.shouldStop ?? false
            self.timerViewModel?.shouldStop = !state
        }
        
        
    }
    
    
    @IBAction func didTapChangePlayer(_ sender: UIButton) {
        
        self.timerViewModel?.shouldGoToNextPlayer(to: sender.tag == 0 ? .Back : .Next)
        
    }
    
    
}
