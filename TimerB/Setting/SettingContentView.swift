//
//  SettingContentView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

protocol ContentViewProtocol {
    func resetUIToInitialState()
}

class SettingContentView: UIView {

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var noticeContainer: UIView!
    @IBOutlet var noticeButtons: [IconButton]!
    
    @IBOutlet weak var playerList: UITableView!
    
    let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut)

    var delegate: ContentViewProtocol?
    
    var noticeContainerIsShowing: Bool = false
    
    let noticeManager = NoticeManager()
    
    var playerInfos: [PlayerInfo] = [] {
        didSet {
            self.playerList.isHidden = self.playerInfos.isEmpty
            self.playerList.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    
    private func commoninit() {
        let superView = Bundle.main.loadNibNamed("SettingContentView", owner: self, options: nil)?.first as! UIView
        self.addSubview(superView)
        superView.frame = self.bounds
        superView.layoutIfNeeded()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(self.didTapBackground)))
        
        self.blurView.effect = nil
        self.animator.addAnimations { [weak self] in
            self?.blurView.effect = UIBlurEffect(style: .dark)
        }
        
        self.animator.pausesOnCompletion = true
        
        self.noticeContainer.alpha = 0
        self.playerList.alpha = 0

        self.setPlayerListUI()
        self.setNoticeButtonsEvent()
        
    }


    private func setPlayerListUI() {
        
        self.playerList.setCell(cellName: PlayerCell.self)

        self.playerList.delegate = self
        self.playerList.dataSource = self
        
        self.playerList.layer.cornerRadius = 32
        self.playerList.clipsToBounds = true
        
        self.playerList.tableHeaderView = PlayerListHeader(frame: CGRect(origin: .zero, size: CGSize(width: .mainWidth, height: 70)))
        

    }
    
    private func setNoticeButtonsEvent() {
        for (index, button) in self.noticeButtons.enumerated() {
            
            let type = NoticeManager.NoticeKey(rawValue: index) ?? .SOUND
            self.setButtonUI(button: button,
                             isOn: self.noticeManager.notice(key: type))
            
            button.onClick = {
                let value = self.noticeManager.setNotice(key: type)
                self.setButtonUI(button: button,
                                 isOn: value)
                
            }
        }
    }
    
    private func setButtonUI(button: IconButton, isOn: Bool) {
        button.backgroundColor = isOn ? .white : .clear
        button.tintColor = isOn ? .cardBackground : .white
    }
    
    
    @objc private func didTapBackground() {
        
        self.delegate?.resetUIToInitialState()
        self.resetUIToInitialState()
        
    }
    
    private func resetUIToInitialState() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 0
        } completion: { _ in
            self.alpha = 1
            self.removeFromSuperview()
            self.animator.fractionComplete = 0
            self.noticeContainer.alpha = 0
            self.playerList.alpha = 0
        }
    }
    
    
    func didRecognizePanGesture(state: UIGestureRecognizer.State, intensity: CGFloat) {
        
        switch state {
            
        case .changed:
            self.setBlur(with: intensity)
            break
            
        case .ended:
            if intensity < 0.5 {
                self.resetUIToInitialState()
            } else {
                self.setBlur(with: 1.0)
            }
            break
            
        default:
            break
        }
        
        
    }
    
    
    private func setBlur(with value: CGFloat) {

        self.animator.fractionComplete = value
        
        let shouldShow = value > 0.5 && !self.noticeContainerIsShowing
        let shouldHide = value <= 0.5 && self.noticeContainerIsShowing
        
    
        if value == 1.0 || shouldShow {
            self.setAnimation(willShow: true)
            self.noticeContainerIsShowing = true
        } else if shouldHide {
            self.setAnimation(willShow: false)
            self.noticeContainerIsShowing = false
 
        }

    }

    
    private func setAnimation(willShow: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut]) {
            self.noticeContainer.alpha = willShow ? 1 : 0
            self.playerList.alpha = willShow ? 1 : 0
            let scale: CGFloat = willShow ? 1.1 : 1.0
            self.noticeContainer.transform = CGAffineTransform(scaleX: scale,
                                                               y: scale)
            self.playerList.transform = CGAffineTransform(scaleX: scale,
                                                               y: scale)
        }
    }
    
    
}

extension SettingContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playerInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.loadCell(identifier: PlayerCell.self, indexPath: indexPath)
        cell.info = self.playerInfos[indexPath.row]
        return cell
    }
    
    
}
